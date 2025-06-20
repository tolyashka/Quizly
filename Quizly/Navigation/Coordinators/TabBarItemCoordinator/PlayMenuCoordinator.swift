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
    
    private let networkManager: INetworkManager
    private let dataService: IDataService
    // MARK: - Initialize PlayMenuCoordinator
    
    init(navigationController: UINavigationController, networkManager: INetworkManager, dataService: IDataService) {
        self.navigationController = navigationController
        self.networkManager = networkManager
        self.dataService = dataService
    }
    
    func start() {
        showModule()
    }
    
    func showConfigurationQuestionDetail() {
        let configurationQuestionCoordinator = ConfigurationQuestionCoordinator(navigationController: navigationController)
        configurationQuestionCoordinator.parentCoordinator = self
        childCoordinators.append(configurationQuestionCoordinator)
        configurationQuestionCoordinator.start()
    }
    
    func updateQuestionsConfigurations(with configurations: [QuestionSection: QuestionItemViewModel]?) {
        let resultConfiguration = configurations?.values.compactMap { $0.queryItem }
        networkManager.createURLConfiguration(with: resultConfiguration)
    }
    
    func showQuestionLoadModule() {
        let coordinator = LoadQuestionCoordinator(
            navigationController: navigationController,
            netwowrkManager: networkManager,
            dataService: dataService
        )
        
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
//    func startQuizSession() {
//        networkManager.fetchQuestions { [weak self] questionModel in
//            guard let self else { return }
//            DispatchQueue.main.async {
//                self.detailsQuizSession(with: questionModel)
//            }
//        }
//    }
    
//    private func detailsQuizSession(with questionModel: QuestionModel) {
//        let quizSessionCoordinator = QuizSessionCoordinator(navigationController: navigationController, questionModel: questionModel)
//        quizSessionCoordinator.parentCoordinator = self
//        childCoordinators.append(quizSessionCoordinator)
//        quizSessionCoordinator.start()
//    }
}

// MARK: - Presentation play module
private extension PlayMenuCoordinator {
    func showModule() {
        let presenter = MenuPresenter(coordinator: self, dataService: dataService)
        let viewController = MenuViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
