//
//  QuestionConfiguratorData.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import Foundation

enum QuestionSection: String, CaseIterable, Codable {
    case questionCategory
    case questionsCounts
    case answerType
    case difficultType
}

struct QuestionItemViewModel: Hashable, Codable {
    var id = UUID()
    let title: String
    let isSelected: Bool
}

struct QuestionSectionViewModel: Hashable, Codable {
    var id = UUID()
    let type: QuestionSection
    let items: [QuestionItemViewModel]
    
    var title: String {
        type.rawValue
    }
}
