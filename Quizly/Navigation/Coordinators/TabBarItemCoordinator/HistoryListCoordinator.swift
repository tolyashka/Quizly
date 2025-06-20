//
//  HistoryListCoordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 11.05.2025.
//

import UIKit

final class HistoryListCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    private let dataService: IDataService
    
    init(navigationController: UINavigationController, dataService: IDataService) {
        self.navigationController = navigationController
        self.dataService = dataService
    }
    
    func start() {
        showModule()
    }
    
    func goBack() {
        finish()
        navigationController.popToRootViewController(animated: true)
    }
}

private extension HistoryListCoordinator {
    func showModule() {
        let presenter = HistoryGameSessionPresenter(coordinator: self, dataService: dataService)
        let viewController = HistoryGameSessionViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
