//
//  ConfigurationQuestionCoordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 02.06.2025.
//

import UIKit

final class ConfigurationQuestionCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
    
    func start() {
       showModule()
    }
    
    func dismiss() {
        finish()
        navigationController.popToRootViewController(animated: true)
    }
}

private extension ConfigurationQuestionCoordinator {
    func showModule() {
        let questionFactory = QuestionSectionFactory()
        let configurationStorage = ConfigurationStorage.shared
        let presenter = QuestionConfiguratorPresenter(coordinator: self, model: questionFactory, configuratorStorage: configurationStorage)
        let viewController = QuestionConfiguratorViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
