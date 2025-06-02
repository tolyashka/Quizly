//
//  QuizResultPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 02.06.2025.
//

import UIKit

protocol IQuizResultPresenter {
    func viewDidLoad(_ view: IQuizResultView)
    func didTapBack()
}

final class QuizResultPresenter: IQuizResultPresenter {
    private let quizResultModel: QuizResultModel
    private weak var view: IQuizResultView?
    private let coordinator: Coordinator

    init(quizResultModel: QuizResultModel, coordinator: Coordinator) {
        self.quizResultModel = quizResultModel
        self.coordinator = coordinator
    }

    func viewDidLoad(_ view: IQuizResultView) {
        self.view = view
        let percent = Int((Double(quizResultModel.score) / Double(quizResultModel.total)) * 100)
        view.showScoreText("Результат: \(quizResultModel.score)/\(quizResultModel.total) (\(percent)%)")
    }

    func didTapBack() {
        let coordinator = coordinator as? QuizSessionCoordinator
        coordinator?.finishQuiz()
    }
}
