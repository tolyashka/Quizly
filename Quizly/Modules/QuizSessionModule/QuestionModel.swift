//
//  QuestionModel.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import Foundation

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
    let incorrectAnswers: [String]
    
    var correctAnswerCount: Int {
        return 1
    }
    
    var answersCount: Int {
        incorrectAnswers.count + correctAnswerCount
    }

    func getRandomQuestions(correctIndex: inout Int) -> [String] {
        var randomQuestions = incorrectAnswers
        correctIndex = Int.random(in: 0..<answersCount)
        randomQuestions.insert(correctAnswer, at: correctIndex)
        return randomQuestions
    }

    private enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
