//
//  MenuPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 11.05.2025.
//

import UIKit

final class MenuPresenter {
    private weak var view: IStartMenuView?
    private weak var coordinator: Coordinator?
    private let networkManager: INetworkManager
    
    init(coordinator: Coordinator, networkManager: INetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
}

extension MenuPresenter: IMenuPresenter {
    func viewDidLoad(view: IStartMenuView) {
        self.view = view
    }
    
    func chooseCategory() {
        let coordinator = coordinator as? PlayMenuCoordinator
        coordinator?.showConfigurationQuestionDetail()
    }
    
    func startQuizSession() {
        let coordinator = coordinator as? PlayMenuCoordinator
        coordinator?.startQuizSession()
    }
}
