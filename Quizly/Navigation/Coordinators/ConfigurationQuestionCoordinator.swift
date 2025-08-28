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
    
    private let questionConfigurator: SelectableConfigurator
    private let navigationController: UINavigationController
    private let savableConfigurator: SavableConfigurator
    private let configurationNotificationCenter: QuestionConfigurationEvent
    private let questionModel : [QuestionSectionViewModel]
    
    init(navigationController: UINavigationController,
         questionConfigurator: SelectableConfigurator,
         savableConfigurator: SavableConfigurator,
         configurationNotificationCenter: QuestionConfigurationEvent,
         questionModel: [QuestionSectionViewModel]) {
        self.navigationController = navigationController
        self.questionConfigurator = questionConfigurator
        self.savableConfigurator = savableConfigurator
        self.configurationNotificationCenter = configurationNotificationCenter
        self.questionModel = questionModel
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
        let presenter = QuestionConfiguratorPresenter(
            coordinator: self,
            model: questionModel,
            configurationSelector: questionConfigurator,
            savableConfigurator: savableConfigurator,
            configurationNotificationCenter: configurationNotificationCenter
        )
        let viewController = QuestionConfiguratorViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
