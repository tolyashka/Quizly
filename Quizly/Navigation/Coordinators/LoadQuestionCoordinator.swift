//
//  LoadQuestionCoordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 13.06.2025.
//

import UIKit

final class LoadQuestionCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let networkManager: INetworkManager
    private let dataService: IDataService
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, netwowrkManager: INetworkManager, dataService: IDataService) {
        self.navigationController = navigationController
        self.networkManager = netwowrkManager
        self.dataService = dataService
    }
    
    func start() {
        showModule()
    }
    
    func showQuizSessionModule(with questionModel: QuestionModel) {
        let quizSessionCoordinator = QuizSessionCoordinator(navigationController: navigationController, questionModel: questionModel, dataService: dataService)
        quizSessionCoordinator.start()
    }
    
    func showMenuModule() {
        navigationController.popToRootViewController(animated: true)
    }
}

private extension LoadQuestionCoordinator {
    func showModule() {
        let presenter = LoadQuestionPresenter(coordinator: self, networkManager: networkManager)
        let viewController = LoadQuestionViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
