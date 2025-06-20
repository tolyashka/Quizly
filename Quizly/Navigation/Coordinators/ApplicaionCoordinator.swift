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
    
    init(window: UIWindow, navigationController: UINavigationController, networkManager: INetworkManager, dataService: IDataService) {
        self.window = window
        self.navigationController = navigationController
        self.networkManager = networkManager
        self.dataService = dataService
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
        let coordinator = TabBarCoordinator(window: window, networkManager: networkManager, dataService: dataService)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
