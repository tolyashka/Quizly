//
//  QuestionsBuilder.swift
//  Quizly
//
//  Created by Анатолий Лушников on 31.05.2025.
//

import Foundation

protocol IQuestionSectionFactory {
    func makeSections() -> [QuestionSectionViewModel]
}

final class QuestionSectionFactory: IQuestionSectionFactory {
    func makeSections() -> [QuestionSectionViewModel] {
        return [
            QuestionSectionViewModel(
                type: .questionCategory,
                items: composeItems(QuestionConfigurator.QuestionCategory.allCases)
            ),
            QuestionSectionViewModel(
                type: .questionsCounts,
                items: composeItems(QuestionConfigurator.QuestionsCounts.allCases)
            ),
            QuestionSectionViewModel(
                type: .difficultType,
                items: composeItems(QuestionConfigurator.DifficultType.allCases)
            ),
            QuestionSectionViewModel(
                type: .answerType,
                items: composeItems(QuestionConfigurator.AnswerType.allCases)
            )
        ]
    }
    
    private func composeItems<T: IQuestionConfiguration>(_ items: [T], defaultSelectedItem: Int = 0) -> [QuestionItemViewModel] {
        return items.enumerated().map { index, item in
            QuestionItemViewModel(
                id: UUID(),
                title: item.title,
                isSelected: index == defaultSelectedItem,
                queryItem: item.queryItem
            )
        }
    }
}
