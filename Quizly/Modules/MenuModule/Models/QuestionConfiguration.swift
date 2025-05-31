//
//  QuestionCategory.swift
//  Quizly
//
//  Created by Анатолий Лушников on 12.05.2025.
//

import Foundation

protocol IQuestionConfiguration {
    var title: String { get }
    var apiKey: String { get }
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
        
        var apiKey: String {
            let result: String
            switch self {
            case .any:              result = ""
            case .generalKnowlage:  result = "category=9"
            case .books:            result = "category=10"
            case .films:            result = "category=11"
            case .music:            result = "category=12"
            case .television:       result = "category=14"
            case .videoGames:       result = "category=15"
            case .boardGames:       result = "category=16"
            case .natureScience:    result = "category=17"
            case .computerScience:  result = "category=18"
            case .mathematic:       result = "category=19"
            case .sports:           result = "category=21"
            case .geography:        result = "category=22"
            case .history:          result = "category=23"
            case .politics:         result = "category=24"
            case .art:              result = "category=25"
            case .celebrities:      result = "category=26"
            case .animals:          result = "category=27"
            case .vehicles:         result = "category=28"
            case .comics:           result = "category=29"
            case .gadgets:          result = "category=30"
            case .anime:            result = "category=31"
            case .cartoon:          result = "category=32"
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
        
        var apiKey: String {
            let result: String
            switch self {
            case .ten:      result = "amount=10"
            case .twenty:   result = "amount=20"
            case .thirty:   result = "amount=30"
            case .fifty:    result = "amount=50"
            case .hundred:  result = "amount=100"
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
        
        var apiKey: String {
            let result: String
            switch self {
            case .any:      result = ""
            case .easy:     result = "difficulty=easy"
            case .medium:   result = "difficulty=medium"
            case .hard:     result = "difficulty=hard"
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
        
        var apiKey: String {
            let result: String
            switch self {
            case .any:          result = ""
            case .multiple:     result = "type=multiple"
            case .boolean:      result = "type=boolean"
            }
            return result
        }
    }
}
