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
    private let questionModel: QuestionModel
    
    init(navigationController: UINavigationController, questionModel: QuestionModel) {
        self.navigationController = navigationController
        self.questionModel = questionModel
    }
    
    func start() {
        showModule()
    }
    
    func dismiss() {
        finish()
        navigationController.popToRootViewController(animated: true)
    }
    
    func showQuizResult(quizResultModel: QuizResultModel) {
        let presenter = QuizResultPresenter(quizResultModel: quizResultModel, coordinator: self)
        let viewController = QuizResultViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func finishQuiz() {
        navigationController.popToRootViewController(animated: true)
    }
}

private extension QuizSessionCoordinator {
    func showModule() {
        let presenter = QuizSessionPresenter(coordinator: self, questionModel: questionModel)
        let viewController = QuizViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
