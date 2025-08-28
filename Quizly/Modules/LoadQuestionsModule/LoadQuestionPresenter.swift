//
//  LoadQuestionPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 13.06.2025.
//

import Foundation

protocol ILoadQuestionPresenter: AnyObject {
    func transitionLoad(state: QuestionLoadState)
    func viewDidLoaded(_ view: ILoadQuestionView)
    func pushLoadedQuestion(_ questionModel: QuestionModel)
    func getQuestionConfigurationTitle() -> String?
    func popWithError()
}

final class LoadQuestionPresenter {
    private weak var coordinator: Coordinator?
    private let networkManager: INetworkManager
    private weak var view: ILoadQuestionView?
    private let savedConfiguration: SavableConfigurator
    private var loadState: QuestionLoadState?
    
    init(coordinator: Coordinator,
         networkManager: INetworkManager,
         savedConfiguration: SavableConfigurator
    ) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        self.savedConfiguration = savedConfiguration
    }
    
    private func fetchData() {
        networkManager.fetchQuestions { [weak self] loadState in
            guard let self else { return }
            switch loadState {
            case .beingUploaded:
                self.transitionLoad(state: LoadingState())
            case .uploaded:
                self.transitionLoad(state: UploadedState())
            case .uploadWithError(let error):
                self.transitionLoad(state: FailureUploadState(error: error))
            }
        } completionHandler: { [weak self] questionModel in
            guard let self else { return }
            DispatchQueue.main.async {
                self.pushLoadedQuestion(questionModel)
            }
        }
    }
}

extension LoadQuestionPresenter: ILoadQuestionPresenter {
    func popWithError() {
        let coordinator = coordinator as? LoadQuestionCoordinator
        coordinator?.showMenuModule()
    }
    
    func pushLoadedQuestion(_ questionModel: QuestionModel) {
        let coordinator = coordinator as? LoadQuestionCoordinator
        coordinator?.showQuizSessionModule(with: questionModel)
    }
    
    func viewDidLoaded(_ view: ILoadQuestionView) {
        self.view = view
        self.view?.updateQuestionConfiguration(with: getQuestionConfigurationTitle())
        fetchData()
    }
    
    func transitionLoad(state: QuestionLoadState) {
        self.loadState = state
        loadState?.execute(with: view)
    }
    
    func getQuestionConfigurationTitle() -> String? {
        savedConfiguration.currentSavedConfiguration?.compactMap { $0.title + "\n" }.joined()
    }
}
