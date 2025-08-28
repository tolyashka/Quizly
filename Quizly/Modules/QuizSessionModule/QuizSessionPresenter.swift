//
//  QuizSessionPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import Foundation

protocol IQuizSessionPresenter: AnyObject {
    func getQuestionsCount() -> Int64 
    func viewDidLoad(_ view: IQuizSessionView)
    func didSelectAnswer(at index: Int)
}

final class QuizSessionPresenter {
    private weak var view: IQuizSessionView?
    private let gameSession: IGameSession
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator, gameSession: IGameSession) {
        self.gameSession = gameSession
        self.coordinator = coordinator
        configureGameSession()
    }
    
    private func configureGameSession() {
        gameSession.delegate = self
    }
}

extension QuizSessionPresenter: IQuizSessionPresenter {
    func viewDidLoad(_ view: any IQuizSessionView) {
        self.view = view
        showQuestion()
    }
    
    func didSelectAnswer(at index: Int) {
        view?.updateInteractions(isEnabled: false)
        gameSession.didSelectItem(at: index)
    }
    
    func getQuestionsCount() -> Int64 {
        Int64(gameSession.sessionInformation.countQuestions)
    }
}

extension QuizSessionPresenter: QuizStateDelegate {
    func showAnswerResult(correctIndex: Int, uncorrectIndex: Int?) {
        view?.updateAnswers(correctIndex: correctIndex, uncorrectIndex: uncorrectIndex)
    }
    
    func showNextQuestion(_ question: QuestionResult) {
        showNextQuestion()
    }
    
    func showQuizFinished() {
        showResultModule()
    }
}

private extension QuizSessionPresenter {
    func showQuestion() {
        view?.displayQuestion(gameSession.sessionInformation.getTitleQuestion)
        view?.showAnswers(gameSession.sessionInformation.getTitleAnswers)
        view?.showProgress(current: gameSession.sessionInformation.getCurrentQuestionPosition)
    }
    
    func showNextQuestion() {
        showQuestion()
        view?.updateInteractions(isEnabled: true)
    }
    
    func showResultModule() {
        guard let coordinator = coordinator as? QuizSessionCoordinator else { return }
        let sessionResult = gameSession.returnSessionResults()
        coordinator.showQuizResult(quizResultModel: sessionResult)
    }
}
