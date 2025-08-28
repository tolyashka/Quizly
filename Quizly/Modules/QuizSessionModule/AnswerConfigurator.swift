//
//  AnswerConfigurator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 20.08.2025.
//

protocol IAnswerConfigurator {
    var answerCalculator: IAnswerCalculator { get }
    
    func nextQuestion()
    func answersForCurrenctQuestion() -> QuestionResult
}

final class AnswerConfigurator: IAnswerConfigurator {
    private(set) var answerCalculator: IAnswerCalculator
    private let answersModel: QuestionModel
    private let questionRandomizer: Randomizable
    private var cachedQuestion: QuestionResult?
    
    private var currentQuestion: ResultItem {
        return answersModel.results[answerCalculator.questionIndex]
    }
    
    init(answersModel: QuestionModel,
         questionRandomizer: Randomizable,
         answerCalculator: IAnswerCalculator
    ) {
        self.answersModel = answersModel
        self.questionRandomizer = questionRandomizer
        self.answerCalculator = answerCalculator
    }
    
    func answersForCurrenctQuestion() -> QuestionResult {
        if let cached = cachedQuestion {
            return cached
        }
        let answersCount = currentQuestion.answersCount
        let randomIndex = questionRandomizer.getRandomIndex(withCapacity: answersCount)
        let result = generateAnswers(correctIndex: randomIndex)
        cachedQuestion = result
        return result
    }
    
    func nextQuestion() {
        cachedQuestion = nil
        
    }
    
    private func generateAnswers(correctIndex: Int) -> QuestionResult {
        var answers = currentQuestion.incorrectAnswers
        let correctAnswer = currentQuestion.correctAnswer
        answers.insert(correctAnswer, at: correctIndex)
        return QuestionResult(
            question: currentQuestion.question,
            answers: answers,
            correctIndex: correctIndex
        )
    }
}

