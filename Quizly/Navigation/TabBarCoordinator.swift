//
//  TabBarCoordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 06.05.2025.
//

import UIKit

fileprivate enum TabBarImageView: String, CaseIterable {
    case play = "gamecontroller"
    case history = "clock"
}

fileprivate enum TabBarTitle: String {
    case play = "Играть"
    case history = "История"
}

final class TabBarCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    private var window: UIWindow
    private let networkManager: INetworkManager
    private var tabBarController: TabBarController?
    
    // MARK: - Initialize main coordinator
    init(window: UIWindow, networkManager: INetworkManager) {
        self.window = window
        self.networkManager = networkManager
    }
    
    func start() {
        showTabBarFlow()
    }
}

// MARK: - Configure tab bar coordinator elements
private extension TabBarCoordinator {
    func showTabBarFlow() {
        let playCoordinator = makePlayCoordinator()
        let historyListCoordinator = makeHistoryListCoordinator()
        let coordinators: [Coordinator] = [playCoordinator/*, historyListCoordinator*/]
        
        childCoordinators.append(contentsOf: coordinators)
        
        setupTabBarController(with: [
            playCoordinator.navigationController,
//            historyListCoordinator.navigationController
        ])
    }
    
    func makePlayCoordinator() -> PlayMenuCoordinator {
        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem(
            title: TabBarTitle.play.rawValue,
            image: UIImage(systemName: TabBarImageView.play.rawValue),
            selectedImage: UIImage(systemName: TabBarImageView.play.rawValue)
        )
        navController.setNavigationBarHidden(true, animated: false)
        
        let coordinator = PlayMenuCoordinator(navigationController: navController, networkManager: networkManager)
        coordinator.parentCoordinator = self
        coordinator.start()
        return coordinator
    }
    
    func makeHistoryListCoordinator() -> HistoryListCoordinator {
        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem(
            title: TabBarTitle.history.rawValue,
            image: UIImage(systemName: TabBarImageView.history.rawValue),
            selectedImage: UIImage(systemName: TabBarImageView.history.rawValue)
        )
        navController.setNavigationBarHidden(true, animated: false)
        
        let coordinator = HistoryListCoordinator(navigationController: navController)
        coordinator.parentCoordinator = self
        coordinator.start()
        return coordinator
    }
    
    func setupTabBarController(with controllers: [UINavigationController]) {
        tabBarController = TabBarController(tabBarControllers: controllers)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
