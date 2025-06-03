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

struct QueryItem: Hashable, Codable {
    let name: String
    let value: String?
}

struct QuestionItemViewModel: Hashable, Codable {
    var id = UUID()
    let title: String
    let isSelected: Bool
    let queryItem: QueryItem?
}

struct QuestionSectionViewModel: Hashable, Codable {
    var id = UUID()
    let type: QuestionSection
    let items: [QuestionItemViewModel]
    
    var title: String {
        type.rawValue
    }
}
