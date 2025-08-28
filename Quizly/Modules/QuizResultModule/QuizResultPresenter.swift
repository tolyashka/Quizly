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
    private let dataService: IDataService
    
    init(quizResultModel: QuizResultModel, dataService: IDataService ,coordinator: Coordinator) {
        self.quizResultModel = quizResultModel
        self.coordinator = coordinator
        self.dataService = dataService
    }

    func viewDidLoad(_ view: IQuizResultView) {
        self.view = view
        view.showScoreText(
            QuizResultConstants.ResultPresenter.showScoreText(
                score: quizResultModel.score,
                total: quizResultModel.questionsCount,
                percent: quizResultModel.percent
            ).title
        )
        saveResults()
    }

    func didTapBack() {
        let coordinator = coordinator as? QuizSessionCoordinator
        coordinator?.finishQuiz()
    }
    
    private func saveResults() {
        dataService.addResult(quizResultModel)
    }
}
