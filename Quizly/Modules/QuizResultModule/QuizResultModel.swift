//
//  QuizResultModel.swift
//  Quizly
//
//  Created by Анатолий Лушников on 02.06.2025.
//

import Foundation

struct QuizResultModel {
    let date: Date
    let score: Int
    let total: Int
    let percent: Double
}

struct QuestionConfigModel {
    let id: UUID
    let title: String
    let difficultyLevel: String
    let countQuestions: Int32
    let answerType: String
}
