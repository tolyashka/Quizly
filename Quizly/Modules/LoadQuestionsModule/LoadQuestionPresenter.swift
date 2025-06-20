//
//  LoadQuestionPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 13.06.2025.
//

import Foundation

protocol ILoadQuestionPresenter: AnyObject {
    func viewDidLoaded(_ view: ILoadQuestionView)
    func popWithError()
}

final class LoadQuestionPresenter: ILoadQuestionPresenter {
    private weak var coordinator: Coordinator?
    private let networkManager: INetworkManager
    private weak var view: ILoadQuestionView?
    
    init(coordinator: Coordinator, networkManager: INetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    func viewDidLoaded(_ view: any ILoadQuestionView) {
        self.view = view
        fetchData()
    }
    // !!!!
    
    func fetchData() {
        networkManager.fetchQuestions { [weak view] isLoaded in
            switch isLoaded {
            case .beingUploaded:
                DispatchQueue.main.async {
                    view?.updateLoad(with: true)
                }
            case .uploaded:
                DispatchQueue.main.async {
                    view?.updateLoad(with: false)
                }
            case .uploadWithError(let error):
                DispatchQueue.main.async {
                    view?.loadWithError(titleError: error)
                }
            }
        } completionHandler: { [weak self] questionModel in
            guard let self else { return }
            DispatchQueue.main.async {
                self.pushLoadedQuestion(questionModel)
            }
        }
    }
    func pushLoadedQuestion(_ questionModel: QuestionModel) {
        let coordinator = coordinator as? LoadQuestionCoordinator
        coordinator?.showQuizSessionModule(with: questionModel)
    }
    
    func popWithError() {
        let coordinator = coordinator as? LoadQuestionCoordinator
        coordinator?.showMenuModule()
    }
}
