//
//  QuizSessionCoordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 02.06.2025.
//

import UIKit

final class QuizSessionCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let savedConfiguration: SavableConfigurator
    private let questionModel: QuestionModel
    private let dataService: IDataService
    
    init(navigationController: UINavigationController, questionModel: QuestionModel, dataService: IDataService, savedConfiguration: SavableConfigurator) {
        self.navigationController = navigationController
        self.questionModel = questionModel
        self.dataService = dataService
        self.savedConfiguration = savedConfiguration
    }
    
    func start() {
        showModule()
    }
    
    func dismiss() {
        finish()
        navigationController.popToRootViewController(animated: true)
    }
    
    func showQuizResult(quizResultModel: QuizResultModel) {
        let presenter = QuizResultPresenter(quizResultModel: quizResultModel, dataService: dataService, coordinator: self)
        let viewController = QuizResultViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func finishQuiz() {
        dismiss()
    }
}

private extension QuizSessionCoordinator {
    func showModule() {
        // !!!
        let answerCalculator = AnswerCalculator(questionOffset: 1, model: questionModel)
        let answerConfiguratior = AnswerConfigurator(
            answersModel: questionModel,
            questionRandomizer: QuestionRandomizer(),
            answerCalculator: answerCalculator
        )

        let answerChecker = SingleAnswerChecker(answerConfigurator: answerConfiguratior, answerCalculator: answerCalculator)
        let currentQuestion = SessionInformation(gameModel: questionModel, answerConfigurator: answerConfiguratior, savedConfiguration: savedConfiguration)
        let changeQuestionConfiguration = ChangeQuestionConfiguration(delayForChangedQuestion: 1.5)

        let quizSessionState = QuizSessionState(
            configurator: answerConfiguratior,
            checker: answerChecker,
            changeAnswerConfigurator: changeQuestionConfiguration
        )
        
        let sessionInformation = SessionInformation(
            gameModel: questionModel,
            answerConfigurator: answerConfiguratior,
            savedConfiguration: savedConfiguration
        )
        
        let resultGameSession = ResultGameSession()
        
        let gameSession = GameSession(
            sessionState: quizSessionState,
            changeAnswerConfigurator: changeQuestionConfiguration,
            sessionInformation: sessionInformation, resultGameSession: resultGameSession
        )

        let presenter = QuizSessionPresenter(coordinator: self, gameSession: gameSession)
        let viewController = QuizViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
