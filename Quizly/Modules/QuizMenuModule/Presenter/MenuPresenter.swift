//
//  MenuPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 11.05.2025.
//

import UIKit

final class MenuPresenter {
    private weak var view: IStartMenuView?
    private var coordinator: Coordinator?
    private let questionConfigurator: SelectableConfigurator
    private let dataService: IDataService
    private let configurationNotificationCenter: QuestionConfigurationEvent
    private let savableConfigurator: SavableConfigurator
    private var token: NSObjectProtocol?
    
    init(coordinator: Coordinator,
         questionConfigurator: SelectableConfigurator,
         dataService: IDataService,
         savableConfigurator: SavableConfigurator,
         configurationNotificationCenter: QuestionConfigurationEvent
    ) {
        self.coordinator = coordinator
        self.questionConfigurator = questionConfigurator
        self.dataService = dataService
        self.savableConfigurator = savableConfigurator
        self.configurationNotificationCenter = configurationNotificationCenter
        
        setQuestionConfigurationObserver()
    }
    
    deinit {
        if let token = token {
            configurationNotificationCenter.removeObserve(with: token)
        }
    }
}

extension MenuPresenter: IMenuPresenter {
    func viewDidLoad(view: IStartMenuView) {
        self.view = view
        self.view?.update(with: questionConfigurator.itemValues)
        updateQuestionConfigurationTitles()
    }
    
    func chooseCategory() {
        let coordinator = coordinator as? PlayMenuCoordinator
        coordinator?.showConfigurationQuestionDetail()
    }
    
    func updateQuestionConfigurationTitles() {
        guard let currentConfiguration = savableConfigurator.currentSavedConfiguration else { return }
        view?.update(with: currentConfiguration)
    }
}

// Coordinator
extension MenuPresenter {
    func startQuizSession() {
//        dataService.saveQuestionConfig(config)
//        dataService.setActiveConfigID(config.id)
        
        let coordinator = coordinator as? PlayMenuCoordinator
        coordinator?.updateQuestionsConfigurations(with: questionConfigurator.itemValues)
        coordinator?.showQuestionLoadModule()
    }
}

private extension MenuPresenter {
    func setQuestionConfigurationObserver(with event: Event<[QuestionItemViewModel]> = .userDidSelectItem) {
        token = configurationNotificationCenter.observe(event) { selectedItems in
            self.view?.update(with: selectedItems)
        }
    }
}
