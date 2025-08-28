//
//  ApplicaionCoordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 09.06.2025.
//

import UIKit

final class ApplicaionCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let networkManager: INetworkManager
    private let navigationController: UINavigationController
    private let dataService: IDataService
    private let configurationSaver: SavableConfigurator
    private let selectableConfigurator: SelectableConfigurator
    private let defaultAPIModel: [QuestionSectionViewModel]
    
    init(window: UIWindow,
         navigationController: UINavigationController,
         networkManager: INetworkManager,
         dataService: IDataService,
         configurationSaver: SavableConfigurator,
         selectableConfigurator: SelectableConfigurator,
         defaultAPIModel: [QuestionSectionViewModel]) {
        self.window = window
        self.navigationController = navigationController
        self.networkManager = networkManager
        self.dataService = dataService
        self.configurationSaver = configurationSaver
        self.selectableConfigurator = selectableConfigurator
        self.defaultAPIModel = defaultAPIModel
    }
    
    func start() {
        showTabBarModule()
    }

    func dismiss() {
        finish()
        navigationController.popToRootViewController(animated: true)
    }
}

private extension ApplicaionCoordinator {
    func showTabBarModule() {
        let coordinator = TabBarCoordinator(
            window: window,
            networkManager: networkManager,
            dataService: dataService,
            configurationSaver: configurationSaver,
            selectableConfigurator: selectableConfigurator,
            defaultAPIModel: defaultAPIModel
        )
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
