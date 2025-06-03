//
//  INetworkService.swift
//  Quizly
//
//  Created by Анатолий Лушников on 31.05.2025.
//

enum NetworkError: Error {
    case urlSessionError(String)
    case serverError(String = "Invalid API Key")
    case invalidResponse(String = "Invalid response from server")
    case decodingError(String = "Error parsing server response")
    case invalidURL
}
