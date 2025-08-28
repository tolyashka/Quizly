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

final class QuestionSectionViewModel: Hashable, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case items
    }
    
    let id = UUID()
    let type: QuestionSection
    let items: [QuestionItemViewModel]

    var title: String {
        type.rawValue
    }

    var selectedItem: QuestionItemViewModel? {
        items.first(where: { $0.isSelected })
    }
    
    init(type: QuestionSection, items: [QuestionItemViewModel]) {
        self.type = type
        self.items = items
    }
    
    static func == (lhs: QuestionSectionViewModel, rhs: QuestionSectionViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


final class QuestionItemViewModel: Hashable, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case queryItem
        case isSelected
    }
    
    let id: UUID
    let title: String
    let queryItem: URLQueryItem?
    var isSelected: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        queryItem: URLQueryItem?,
        isSelected: Bool = false
    ) {
        self.id = id
        self.title = title
        self.queryItem = queryItem
        self.isSelected = isSelected
    }
    
    static func == (lhs: QuestionItemViewModel, rhs: QuestionItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
