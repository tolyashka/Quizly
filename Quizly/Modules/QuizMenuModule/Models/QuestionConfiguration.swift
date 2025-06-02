//
//  QuestionCategory.swift
//  Quizly
//
//  Created by Анатолий Лушников on 12.05.2025.
//

import Foundation

protocol IQuestionConfiguration {
    var title: String { get }
    var queryItem: QueryItem? { get }
}

enum QuestionConfigurator {
    enum QuestionCategory: String, IQuestionConfiguration, CaseIterable {
        case any             = "Случайные вопросы"
        case generalKnowlage = "Общие знания"
        case books           = "Книги"
        case films           = "Фильмы"
        case music           = "Музыка"
        case television      = "Телешоу"
        case videoGames      = "Видеоигры"
        case boardGames      = "Настольные игры"
        case natureScience   = "Биология"
        case computerScience = "Компьютерные науки"
        case mathematic      = "Математика"
        case sports          = "Спорт"
        case geography       = "География"
        case history         = "История"
        case politics        = "Политика"
        case art             = "Искусство"
        case celebrities     = "Знаменитости"
        case animals         = "Животные"
        case vehicles        = "Машины"
        case comics          = "Комиксы"
        case gadgets         = "Современная техника"
        case anime           = "Аниме"
        case cartoon         = "Мультфильмы"
        
        var title: String {
            self.rawValue
        }
        
        var queryItem: QueryItem? {
            let result: QueryItem?
            switch self {
            case .any:              result = nil
            case .generalKnowlage:  result = QueryItem(name: "category", value: "9")
            case .books:            result = QueryItem(name: "category", value: "10")
            case .films:            result = QueryItem(name: "category", value: "11")
            case .music:            result = QueryItem(name: "category", value: "12")
            case .television:       result = QueryItem(name: "category", value: "14")
            case .videoGames:       result = QueryItem(name: "category", value: "15")
            case .boardGames:       result = QueryItem(name: "category", value: "16")
            case .natureScience:    result = QueryItem(name: "category", value: "17")
            case .computerScience:  result = QueryItem(name: "category", value: "18")
            case .mathematic:       result = QueryItem(name: "category", value: "19")
            case .sports:           result = QueryItem(name: "category", value: "21")
            case .geography:        result = QueryItem(name: "category", value: "22")
            case .history:          result = QueryItem(name: "category", value: "23")
            case .politics:         result = QueryItem(name: "category", value: "24")
            case .art:              result = QueryItem(name: "category", value: "25")
            case .celebrities:      result = QueryItem(name: "category", value: "26")
            case .animals:          result = QueryItem(name: "category", value: "27")
            case .vehicles:         result = QueryItem(name: "category", value: "28")
            case .comics:           result = QueryItem(name: "category", value: "29")
            case .gadgets:          result = QueryItem(name: "category", value: "30")
            case .anime:            result = QueryItem(name: "category", value: "31")
            case .cartoon:          result = QueryItem(name: "category", value: "32")
            }
            return result
        }
    }
    
    enum QuestionsCounts: String, IQuestionConfiguration, CaseIterable {
        case ten     = "10 случайных"
        case twenty  = "20 случайных"
        case thirty  = "30 случайных"
        case fifty   = "50 случайных"
        case hundred = "100 случайных"
        
        var title: String {
            self.rawValue
        }
        
        var queryItem: QueryItem? {
            let result: QueryItem
            switch self {
            case .ten:      result = QueryItem(name: "amount", value: "10")
            case .twenty:   result = QueryItem(name: "amount", value: "20")
            case .thirty:   result = QueryItem(name: "amount", value: "30")
            case .fifty:    result = QueryItem(name: "amount", value: "50")
            case .hundred:  result = QueryItem(name: "amount", value: "100")
            }
            return result
        }
    }
    
    enum DifficultType: String, IQuestionConfiguration, CaseIterable {
        case any    = "Любой уровень"
        case easy   = "Легко"
        case medium = "Сложно"
        case hard   = "Очень сложно"
        
        var title: String {
            self.rawValue
        }
        
        var queryItem: QueryItem? {
            let result: QueryItem?
            switch self {
            case .any:      result = nil
            case .easy:     result = QueryItem(name: "difficulty", value: "easy")
            case .medium:   result = QueryItem(name: "difficulty", value: "medium")
            case .hard:     result = QueryItem(name: "difficulty", value: "hard")
            }
            return result
        }
    }
    
    enum AnswerType: String, IQuestionConfiguration, CaseIterable {
        case any      = "Любой тип ответов"
        case multiple = "Множество ответов"
        case boolean  = "Правда или ложь"
        
        var title: String {
            self.rawValue
        }
        
        var queryItem: QueryItem? {
            let result: QueryItem?
            switch self {
            case .any:          result = nil
            case .multiple:     result = QueryItem(name: "type", value: "multiple")
            case .boolean:      result = QueryItem(name: "type", value: "boolean")
            }
            return result
        }
    }
}
