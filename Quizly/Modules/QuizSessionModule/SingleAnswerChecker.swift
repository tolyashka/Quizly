//
//  AnswerChecker.swift
//  Quizly
//
//  Created by Анатолий Лушников on 20.08.2025.
//

protocol IAnswerChecker {
    var answerCalculator: IAnswerCalculator { get }
    func isCorrectAnswer(with indexAnswer: Int) -> (correct: Int, uncorrect: Int?)
}

final class SingleAnswerChecker: IAnswerChecker {
    private let answerConfigurator: IAnswerConfigurator
    private(set) var answerCalculator: IAnswerCalculator
    
    init(answerConfigurator: IAnswerConfigurator,
         answerCalculator: IAnswerCalculator
    ) {
        self.answerConfigurator = answerConfigurator
        self.answerCalculator = answerCalculator
    }
    
    func isCorrectAnswer(with indexAnswer: Int) -> (correct: Int, uncorrect: Int?) {
        var result: (correct: Int, uncorrect: Int?)
        let currectAnswers = answerConfigurator.answersForCurrenctQuestion()
        let correctIndex = currectAnswers.correctIndex
        let isCorrectAnswer = currectAnswers.correctIndex == indexAnswer
        
        if isCorrectAnswer {
            result = (correct: correctIndex, uncorrect: nil)
        } else {
            result = (correct: correctIndex, uncorrect: indexAnswer)
        }
        answerCalculator.calculate(withCorrectFlag: isCorrectAnswer)
        answerConfigurator.nextQuestion()
        return result
    }
}
