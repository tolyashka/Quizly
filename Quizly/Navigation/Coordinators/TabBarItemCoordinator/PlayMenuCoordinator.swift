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
    
    private let networkManager: INetworkManager
    private let dataService: IDataService
    private let questionConfigurator: SelectableConfigurator
    private let savableConfigurator: SavableConfigurator
    private let configurationNotificationCenter: QuestionConfigurationEvent
    private let questionModel : [QuestionSectionViewModel]
    
    init(navigationController: UINavigationController,
         networkManager: INetworkManager,
         questionConfigurator: SelectableConfigurator,
         savableConfigurator: SavableConfigurator,
         configurationNotificationCenter: QuestionConfigurationEvent,
         questionModel: [QuestionSectionViewModel],
         dataService: IDataService) {
        self.navigationController = navigationController
        self.networkManager = networkManager
        self.questionConfigurator = questionConfigurator
        self.savableConfigurator = savableConfigurator
        self.configurationNotificationCenter = configurationNotificationCenter
        self.dataService = dataService
        self.questionModel = questionModel
    }
    
    func start() {
        showModule()
    }
    
    func showConfigurationQuestionDetail() {
        let configurationQuestionCoordinator = ConfigurationQuestionCoordinator(
            navigationController: navigationController,
            questionConfigurator: questionConfigurator,
            savableConfigurator: savableConfigurator,
            configurationNotificationCenter: configurationNotificationCenter,
            questionModel: questionModel
        )
        configurationQuestionCoordinator.parentCoordinator = self
        childCoordinators.append(configurationQuestionCoordinator)
        configurationQuestionCoordinator.start()
    }
    
    func updateQuestionsConfigurations(with configurations: [QuestionItemViewModel]) {
        let resultConfiguration = configurations.compactMap { $0.queryItem }
        networkManager.createURLConfiguration(with: resultConfiguration)
    }
    
    func showQuestionLoadModule() {
        let coordinator = LoadQuestionCoordinator(
            navigationController: navigationController,
            netwowrkManager: networkManager,
            dataService: dataService,
            savedConfiguration: savableConfigurator
        )
        
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

// MARK: - Presentation play module
private extension PlayMenuCoordinator {
    func showModule() {
        let presenter = MenuPresenter(
            coordinator: self,
            questionConfigurator: questionConfigurator,
            dataService: dataService,
            savableConfigurator: savableConfigurator,
            configurationNotificationCenter: configurationNotificationCenter
        )
        let viewController = MenuViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
