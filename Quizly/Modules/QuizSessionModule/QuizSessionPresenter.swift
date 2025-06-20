//
//  QuizSessionPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import Foundation

protocol IQuizSessionPresenter: AnyObject {
    func viewDidLoad(_ view: IQuizSessionView)
    func didSelectAnswer(at index: Int)
    func getTotalQuestionsCount() -> Int64
}

final class QuizSessionPresenter {
    private weak var view: IQuizSessionView?
    private let questionModel: QuestionModel
    private weak var coordinator: Coordinator?
    // FIXME: под конфигурацию вопроса тоже отдельную структуру 
    private let delayForChangedQuestion = 1.0
    private var questionIndex = 0
    private let questionOffset = 1
    private var correctAnswerIndex: Int?
    private var correctAnswersCount = 0
    
    init(coordinator: Coordinator, questionModel: QuestionModel) {
        self.questionModel = questionModel
        self.coordinator = coordinator
    }
}

// MARK: - IQuizSessionPresenter
extension QuizSessionPresenter: IQuizSessionPresenter {
    func viewDidLoad(_ view: IQuizSessionView) {
        self.view = view
        loadQuestion()
    }

    func didSelectAnswer(at index: Int) {
        guard let correctIndex = correctAnswerIndex else { return }
        let isCorrect = index == correctIndex
        
        if isCorrect {
            correctAnswersCount += questionOffset
        }
        
        view?.highlightAnswer(at: index, isCorrect: isCorrect)
        view?.disableAllAnswers()

        nextQuestion(with: delayForChangedQuestion)
    }
    
    func getTotalQuestionsCount() -> Int64 {
        Int64(questionModel.questionsCount)
    }
}

private extension QuizSessionPresenter {
    func loadQuestion() {
        guard questionIndex < questionModel.results.count else {
            let coordinator = coordinator as? QuizSessionCoordinator
            
            let resultPercent = calculatePercentage(correctAnswers: correctAnswersCount, totalAnswers: questionModel.questionsCount)
            let quizResultModel = QuizResultModel(date: Date(), score: correctAnswersCount, total: questionModel.questionsCount, percent: resultPercent)
            coordinator?.showQuizResult(quizResultModel: quizResultModel)
            return
        }
        
        var correctIndex = 0
        let question = questionModel.results[questionIndex]
        let answers = question.getRandomQuestions(correctIndex: &correctIndex)
        correctAnswerIndex = correctIndex

        view?.displayQuestion(question.question)
        view?.showAnswers(answers)
        view?.showProgress(current: questionIndex + questionOffset)
    }
    
    func nextQuestion(with delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.questionIndex += self.questionOffset
            self.loadQuestion()
        }
    }
    
    func calculatePercentage(correctAnswers: Int, totalAnswers: Int) -> Double {
        let percentageDivisor = 100.0
        let resultPercent = (Double(correctAnswers) / Double(totalAnswers)) * percentageDivisor
        return resultPercent
    }
}
