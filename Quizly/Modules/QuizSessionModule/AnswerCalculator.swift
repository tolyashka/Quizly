//
//  AnswerCalculator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 19.08.2025.
//

protocol IAnswerCalculator {
    var hasNextQuestion: Bool { get }
    var correctAnswersCount: Int { get }
    var questionIndex: Int { get }
//    var currentResult: ResultGameSessionModel { get }
     
    func calculate(withCorrectFlag correctFlag: Bool)
}

final class AnswerCalculator: IAnswerCalculator {
    var hasNextQuestion: Bool {
        return questionIndex < model.results.count
    }

    
//    var currentResult: ResultGameSessionModel {
//        ResultGameSessionModel(
//            correctAnswersCount: correctAnswersCount
//        )
//    }
    private(set) var correctAnswersCount = 0
    private(set) var questionIndex = 0
    private let questionOffset: Int
    private let model: QuestionModel
    
    init(questionOffset: Int, model: QuestionModel) {
        self.questionOffset = questionOffset
        self.model = model
    }
    
    func calculate(withCorrectFlag correctFlag: Bool) {
        updateCorrectAnswers(withFlag: correctFlag)
        toNextQuestion()
    }
    
    private func updateCorrectAnswers(withFlag correctFlag: Bool) {
        if correctFlag {
            correctAnswersCount += questionOffset
        }
    }
    
    private func toNextQuestion() {
        questionIndex += questionOffset
    }
}
