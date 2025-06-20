//
//  INetworkService.swift
//  Quizly
//
//  Created by Анатолий Лушников on 31.05.2025.
//

import Foundation

enum NetworkError: Error {
//    case serverError(String = "Invalid API Key")
//    case invalidResponse(String = "Invalid response from server")
//    case decodingError(String = "Error parsing server response")
//    case invalidURL(String = "Invalid URL")
    
    case serverError(String = "Ошибка сервера. Повторите попытку позже")
    case invalidResponse(String = "Ошибка запроса. Повторите попытку позже")
    case decodingError(String = "Ошибка при обработке ответа от сервера. Повторите попытку позже")
    case invalidURL(String = "Некорректный адрес запроса")
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError(let message),
             .invalidResponse(let message),
             .decodingError(let message),
             .invalidURL(let message):
            return message
        }
    }
}
