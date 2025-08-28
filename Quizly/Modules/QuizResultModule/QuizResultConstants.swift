//
//  QuizResultConstants.swift
//  Quizly
//
//  Created by Анатолий Лушников on 03.06.2025.
//

import Foundation

enum QuizResultConstants {
    enum ResultPresenter {
        case showScoreText(score: Int, total: Int, percent: Double)
        
        var title: String {
            switch self {
            case .showScoreText(let score, let total, let percent):
                ("Результат: \(score) / \(total) (\(percent)%)")
            }
        }
    }
    enum QuizResulViewtConstants: String {
        case back = "Перейти в меню"
    }
}
