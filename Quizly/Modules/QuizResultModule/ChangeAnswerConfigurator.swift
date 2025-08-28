//
//  ChangeAnswerConfigurator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 19.08.2025.
//

import Foundation

protocol IChangeQuestionConfigurator {
    func nextQuestion(configuration: @escaping () -> Void)
}

struct ChangeQuestionConfiguration: IChangeQuestionConfigurator {
    private let delayForChangedQuestion: Double
    private let questionOffset: Int
    
    init(delayForChangedQuestion: Double,
         questionOffset: Int = 1) {
        self.delayForChangedQuestion = delayForChangedQuestion
        self.questionOffset = questionOffset
    }
    
    func nextQuestion(configuration: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayForChangedQuestion) {
            configuration()
        }
    }
}
