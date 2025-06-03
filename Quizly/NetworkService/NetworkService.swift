//
//  NetworkService.swift
//  Quizly
//
//  Created by Анатолий Лушников on 31.05.2025.
//

import Foundation

protocol INetworkClient {
    func get<ResponseSchema>(
        url: URL?,
        completion: @escaping (Result<ResponseSchema, NetworkError>) -> Void) where ResponseSchema : Decodable
}

final class NetworkClient {
    private let jsonDecoder = JSONDecoder()
}

extension NetworkClient: INetworkClient {
    func get<ResponseSchema>(
        url: URL?,
        completion: @escaping (Result<ResponseSchema, NetworkError>) -> Void) where ResponseSchema : Decodable {
        guard let url else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            if let data {
                do {
                    let result = try jsonDecoder.decode(ResponseSchema.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError(error.localizedDescription)))
                }
                
            } else if let error {
                completion(.failure(.invalidResponse(error.localizedDescription)))
            }
        }
        task.resume()
    }
}
