//
//  QuizResultModel.swift
//  Quizly
//
//  Created by Анатолий Лушников on 02.06.2025.
//

import Foundation

struct QuizResultModel: Hashable {
    let id: UUID
    let date: Date
    let score: Int
    let questionsCount: Int
    let percent: Double
}
