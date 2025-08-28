//
//  GameSession.swift
//  Quizly
//
//  Created by Анатолий Лушников on 19.08.2025.
//

import Foundation

protocol IGameSession: AnyObject {
    var sessionInformation: ISessionInformation { get }
    var delegate: QuizStateDelegate? { get set }
    
    func didSelectItem(at index: Int)
    func returnSessionResults() -> QuizResultModel
}

final class GameSession: IGameSession {
    var sessionInformation: ISessionInformation
    
    weak var delegate: QuizStateDelegate? {
        didSet {
            sessionState.delegate = delegate
        }
    }
    
    private let sessionState: QuizSessionStateConfigurator
    private let changeAnswerConfigurator: IChangeQuestionConfigurator
    private let resultGameSession: IResultGameSession
    
    init(sessionState: QuizSessionStateConfigurator,
         changeAnswerConfigurator: IChangeQuestionConfigurator,
         sessionInformation: ISessionInformation,
         resultGameSession: IResultGameSession
    ) {
        self.sessionState = sessionState
        self.changeAnswerConfigurator = changeAnswerConfigurator
        self.sessionInformation = sessionInformation
        self.resultGameSession = resultGameSession
    }
    
    func didSelectItem(at index: Int) {
        sessionState.selectAnswer(at: index)
        sessionState.handle()
    }
    
    func returnSessionResults() -> QuizResultModel {
        let resultPercentage = resultGameSession.calculatePercentage(
            correctAnswersCount: sessionInformation.getCorrectAnswersCount,
            totalAnswers: sessionInformation.countQuestions
        )
        
        let resultModel = QuizResultModel(
            id: UUID(),
            date: Date(),
            score: sessionInformation.getCorrectAnswersCount,
            questionsCount: sessionInformation.countQuestions,
            percent: resultPercentage
        )
        
        return resultModel
    }
}
