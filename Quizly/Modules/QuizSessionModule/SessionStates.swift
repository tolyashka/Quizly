//
//  SessionStates.swift
//  Quizly
//
//  Created by Анатолий Лушников on 22.08.2025.
//

import Foundation

protocol QuizSessionStatable {
    func selectAnswer(at index: Int)
    func handle()
}

protocol QuizSessionStateConfigurator: AnyObject {
    var changeAnswerConfigurator: IChangeQuestionConfigurator { get }
    var delegate: QuizStateDelegate? { get set }
    var configurator: IAnswerConfigurator { get }
    var checker: IAnswerChecker { get }
    
    func selectAnswer(at index: Int)
    func handle()
    func setState(_ state: QuizSessionStatable)
}

final class QuizSessionState: QuizSessionStateConfigurator {
    var delegate: QuizStateDelegate?
    let configurator: IAnswerConfigurator
    let checker: IAnswerChecker
    let changeAnswerConfigurator: IChangeQuestionConfigurator
    private var state: QuizSessionStatable?
    
    init(configurator: IAnswerConfigurator,
         checker: IAnswerChecker,
         changeAnswerConfigurator: IChangeQuestionConfigurator)
    {
        self.configurator = configurator
        self.checker = checker
        self.changeAnswerConfigurator = changeAnswerConfigurator
        self.state = WaitingForAnswerState(context: self)
    }
    
    func setState(_ state: QuizSessionStatable) {
        self.state = state
    }
    
    func selectAnswer(at index: Int) {
        state?.selectAnswer(at: index)
    }
    
    func handle() {
        state?.handle()
    }
}

protocol QuizStateDelegate: AnyObject {
    func showAnswerResult(correctIndex: Int, uncorrectIndex: Int?)
    func showNextQuestion(_ question: QuestionResult)
    func showQuizFinished()
}

final class WaitingForAnswerState: QuizSessionStatable {
    unowned let context: QuizSessionStateConfigurator
    
    init(context: QuizSessionStateConfigurator) {
        self.context = context
    }
    
    func selectAnswer(at index: Int) {
        let result = context.checker.isCorrectAnswer(with: index)
        context.delegate?.showAnswerResult(correctIndex: result.correct, uncorrectIndex: result.uncorrect)
    }
    
    func handle() {
        context.setState(AnswerCheckedState(context: context))
        context.handle()
    }
}

final class AnswerCheckedState: QuizSessionStatable {
    unowned let context: QuizSessionStateConfigurator
    
    init(context: QuizSessionStateConfigurator) {
        self.context = context
    }
    
    func selectAnswer(at index: Int) { }
    
    func handle() {
        if context.checker.answerCalculator.hasNextQuestion {
            context.changeAnswerConfigurator.nextQuestion { [weak self] in
                guard let self else { return }
                context.configurator.nextQuestion()
                context.setState(QuestionTransitionState(context: context))
                context.handle()
            }
        } else {
            context.setState(FinishedState(context: context))
            context.handle()
        }
    }
}

final class QuestionTransitionState: QuizSessionStatable {
    unowned let context: QuizSessionStateConfigurator
    
    init(context: QuizSessionStateConfigurator) {
        self.context = context
    }
    
    func selectAnswer(at index: Int) { }
    
    func handle() {
        let next = context.configurator.answersForCurrenctQuestion()
        context.delegate?.showNextQuestion(next)
        context.setState(WaitingForAnswerState(context: context))
    }
}

final class FinishedState: QuizSessionStatable {
    unowned let context: QuizSessionStateConfigurator
    init(context: QuizSessionStateConfigurator) {
        self.context = context
    }
    
    func selectAnswer(at index: Int) { }
    
    func handle() {
        context.delegate?.showQuizFinished()
    }
}
