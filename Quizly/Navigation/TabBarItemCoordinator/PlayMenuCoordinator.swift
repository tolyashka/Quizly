//
//  SearchCoordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 06.05.2025.
//

import UIKit
final class PlayMenuCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let networkManager: INetworkManager
    
    // MARK: - Initialize PlayMenuCoordinator
    // Network manager for uploading questions when you click on a button

    init(navigationController: UINavigationController, networkManager: INetworkManager) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }
    
    func start() {
        showModule()
    }
    
    func showConfigurationQuestionDetail() {
        let configurationQuestionCoordinator = ConfigurationQuestionCoordinator(navigationController: navigationController)
        configurationQuestionCoordinator.parentCoordinator = self
        childCoordinators.append(configurationQuestionCoordinator)
        configurationQuestionCoordinator.start()
    }
    
    func startQuizSession() {
        networkManager.fetchQuestions { [weak self] questionModel in
            guard let self else { return }
            DispatchQueue.main.async {
                self.detailsQuizSession(with: questionModel)
            }
        }
    }
    
    private func detailsQuizSession(with questionModel: QuestionModel) {
        let quizSessionCoordinator = QuizSessionCoordinator(navigationController: navigationController, questionModel: questionModel)
        quizSessionCoordinator.parentCoordinator = self
        childCoordinators.append(quizSessionCoordinator)
        quizSessionCoordinator.start()
    }
}

// MARK: - Presentation play module
private extension PlayMenuCoordinator {
    func showModule() {
        let presenter = MenuPresenter(coordinator: self, networkManager: networkManager)
        let viewController = MenuViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
