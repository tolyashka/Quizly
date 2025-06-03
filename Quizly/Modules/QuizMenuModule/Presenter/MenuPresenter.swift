//
//  MenuPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 11.05.2025.
//

import UIKit

final class MenuPresenter {
    typealias QuestionConfiguration = [QuestionSection: QuestionItemViewModel]
    
    private weak var view: IStartMenuView?
    private weak var coordinator: Coordinator?
    
    private var questionConfiguration: QuestionConfiguration? {
        ConfigurationStorage.shared.get(type: QuestionConfiguration.self, forKey: .selectedItems)
    }
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

extension MenuPresenter: IMenuPresenter {
    func viewDidLoad(view: IStartMenuView) {
        self.view = view
        self.view?.update(questionConfiguration: questionConfiguration)
    }
    
    func chooseCategory() {
        let coordinator = coordinator as? PlayMenuCoordinator
        coordinator?.showConfigurationQuestionDetail()
    }
    
    func startQuizSession() {
        let coordinator = coordinator as? PlayMenuCoordinator
        coordinator?.updateQuestionsConfigurations(with: questionConfiguration)
        coordinator?.startQuizSession()
    }
}
