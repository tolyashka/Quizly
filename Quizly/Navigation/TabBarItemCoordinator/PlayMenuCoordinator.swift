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
    private let networkService: INetworkService
    
    init(navigationController: UINavigationController, networkService: INetworkService) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        showModule()
    }
}

private extension PlayMenuCoordinator {
    func showModule() {
        // FIXME: - Пока что разный запуск координатора
//        let presenter = MenuPresenter(coordinator: self)
//        let viewController = MenuViewController(presenter: presenter)
        
        let presenter = QuestionConfiguratorPresenter(coordinator: self, model: QuestionSectionFactory())
        let viewController = QuestionConfiguratorViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
