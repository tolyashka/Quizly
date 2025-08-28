//
//  LoadQuestionStates.swift
//  Quizly
//
//  Created by Анатолий Лушников on 18.08.2025.
//

import Foundation

protocol QuestionLoadState: AnyObject {
    func execute(with view: ILoadQuestionView?)
}

final class LoadingState: QuestionLoadState {
    private let loadingFlag = true
    
    func execute(with view: ILoadQuestionView?) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            view?.updateLoad(with: loadingFlag)
        }
    }
}

final class UploadedState: QuestionLoadState {
    private let loadingFlag = false
    func execute(with view: ILoadQuestionView?) {
        DispatchQueue.main.async { [weak self] in 
            guard let self else { return }
            view?.updateLoad(with: loadingFlag)
        }
    }
}

final class FailureUploadState: QuestionLoadState {
    private let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func execute(with view: ILoadQuestionView?) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            view?.loadWithError(titleError: self.error.localizedDescription)
        }
    }
}
