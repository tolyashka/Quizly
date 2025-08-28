//
//  QuestionRandomizer.swift
//  Quizly
//
//  Created by Анатолий Лушников on 19.08.2025.
//

protocol Randomizable: AnyObject {
    func getRandomIndex(withCapacity capacity: Int) -> Int
}

final class QuestionRandomizer: Randomizable {
    func getRandomIndex(withCapacity capacity: Int) -> Int {
        randomAnswerIndex(countAnswers: capacity)
    }
    
    private func randomAnswerIndex(countAnswers: Int, minimalIndex: Int = 0) -> Int {
        return Int.random(in: minimalIndex ..< countAnswers)
    }
}
