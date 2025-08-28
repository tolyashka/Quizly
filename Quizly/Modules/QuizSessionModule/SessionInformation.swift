//
//  CurrentQuestion.swift
//  Quizly
//
//  Created by Анатолий Лушников on 20.08.2025.
//

import Foundation
protocol ISessionInformation: AnyObject {
    var getTitleQuestion: String { get }
    var getTitleAnswers: [String] { get }
    var getCorrectAnswerIndex: Int { get }
    var getCorrectAnswersCount: Int { get }
    var getCurrentQuestionIndex: Int { get }
    var getCurrentQuestionPosition: Int { get }
    var sessionConfigurations: [String]? { get }
    var countQuestions: Int { get }
}

final class SessionInformation {
    private let answerConfigurator: IAnswerConfigurator
    private let gameModel: QuestionModel
    private let savedConfiguration: SavableConfigurator
    
    private var currentQuestionModel: QuestionResult {
        answerConfigurator.answersForCurrenctQuestion()
    }
    
    init(gameModel: QuestionModel,
         answerConfigurator: IAnswerConfigurator,
         savedConfiguration: SavableConfigurator
    ) {
        self.gameModel = gameModel
        self.answerConfigurator = answerConfigurator
        self.savedConfiguration = savedConfiguration
    }
}

extension SessionInformation: ISessionInformation {
    var getTitleQuestion: String {
        currentQuestionModel.question
    }
    
    var getTitleAnswers: [String] {
        currentQuestionModel.answers
    }
    
    var getCorrectAnswerIndex: Int {
        currentQuestionModel.correctIndex
    }
    
    var getCorrectAnswersCount: Int {
        answerConfigurator.answerCalculator.correctAnswersCount
    }
    
    var getCurrentQuestionIndex: Int {
        answerConfigurator.answerCalculator.questionIndex
    }
    
    var getCurrentQuestionPosition: Int {
        answerConfigurator.answerCalculator.questionIndex + 1
    }
    
    var countQuestions: Int {
        gameModel.questionsCount
    }
    
    var sessionConfigurations: [String]? {
        let configure = savedConfiguration.currentSavedConfiguration
        let result = configure?.compactMap { $0.title }
        return result
    }
}
