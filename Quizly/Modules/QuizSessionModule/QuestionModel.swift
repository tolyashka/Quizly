//
//  QuestionModel.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import Foundation

struct ResultGameSessionModel {
    let correctAnswersCount: Int
}

struct QuestionModel: Decodable {
    let results: [ResultItem]

    var maximalAnswersCount: Int {
        results.map { $0.answersCount }.max() ?? 0
    }
    
    var questionsCount: Int {
        results.count
    }
}

struct ResultItem: Decodable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    var incorrectAnswers: [String]
        
    var correctAnswerCount: Int {
        return 1
    }
    
    var answersCount: Int {
        incorrectAnswers.count + correctAnswerCount
    }

    private enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
