//
//  SceneDelegate.swift
//  Quizly
//
//  Created by Анатолий Лушников on 06.05.2025.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let baseURL = "https://opentdb.com/api.php?" // <----- ou, cringe...
    var window: UIWindow?
    var coordinator: Coordinator?
    // FIXME: - Create application builder
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        let networkManager = NetworkManager(networkClient: NetworkClient(), urlConfigurator: URLConfigurator(urlString: baseURL))
        coordinator = ApplicaionCoordinator(window: window, navigationController: navigationController, networkManager: networkManager, dataService: DataService())
        coordinator?.start()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
//        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

