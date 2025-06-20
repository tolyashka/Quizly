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
    private let dataService: IDataService
    
    private var questionConfiguration: QuestionConfiguration? {
        ConfigurationStorage.shared.get(type: QuestionConfiguration.self, forKey: .selectedItems)
    }
    
    init(coordinator: Coordinator, dataService: IDataService) {
        self.coordinator = coordinator
        self.dataService = dataService
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
    
    func startQuizSession() { // !!!!! 
        let config = QuestionConfigModel(
            id: UUID(),
            title: "История",
            difficultyLevel: "Hard",
            countQuestions: 10,
            answerType: "Single"
        )
        dataService.deleteAllQuizResults()
        dataService.deleteAllQuestionConfigs()
        dataService.setActiveConfig(config)
        print("1", dataService.fetchQuizResults(forConfigWithID: config.id))
        print("2", dataService.fetchAllQuestionConfigs())
        print("3", dataService.fetchLatestResult())
        
        
        let coordinator = coordinator as? PlayMenuCoordinator // !!!!!!!!!!!!!!
        coordinator?.updateQuestionsConfigurations(with: questionConfiguration) // !!!!!!!!!
        coordinator?.showQuestionLoadModule() // !!!!!!!!!!!!!!!!!!
    }
}
