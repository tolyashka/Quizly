//
//  CalculateResult.swift
//  Quizly
//
//  Created by Анатолий Лушников on 19.08.2025.
//

protocol IResultGameSession {
    func calculatePercentage(correctAnswersCount: Int, totalAnswers: Int) -> Double
}

struct ResultGameSession: IResultGameSession {
    private let percentageDivisor: Double
    
    init(percentageDivisor: Double = 100.0) {
        self.percentageDivisor = percentageDivisor
    }
    
    func calculatePercentage(correctAnswersCount: Int, totalAnswers: Int) -> Double {
        let resultPercent = (Double(correctAnswersCount) / Double(totalAnswers)) * percentageDivisor
        return resultPercent
    }
}

