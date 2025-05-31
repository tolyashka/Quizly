//
//  MenuPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 11.05.2025.
//

import UIKit

class MenuPresenter {
    private weak var view: IStartMenuView?
    private weak var coordinator: Coordinator?

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

extension MenuPresenter: IMenuPresenter {
    func viewDidLoad(view: IStartMenuView) {
        self.view = view
    }
    
    func chooseCategory() {

    }
}
