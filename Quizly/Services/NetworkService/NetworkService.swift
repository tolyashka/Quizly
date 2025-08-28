//
//  NetworkService.swift
//  Quizly
//
//  Created by Анатолий Лушников on 31.05.2025.
//

import Foundation

protocol INetworkClient: AnyObject {
    func get<ResponseSchema>(
        url: URL?,
        completion: @escaping (Result<ResponseSchema, NetworkError>) -> Void) where ResponseSchema : Decodable
}

final class NetworkClient: NSObject {
    private let jsonDecoder = JSONDecoder()
    private lazy var session: URLSession = {
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: nil
        )
        return session
    }()
}

extension NetworkClient: INetworkClient {
    func get<ResponseSchema>(
        url: URL?,
        completion: @escaping (Result<ResponseSchema, NetworkError>) -> Void) where ResponseSchema : Decodable {
        guard let url else {
            completion(.failure(.invalidURL()))
            return
        }
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            if let data {
                do {
                    let result = try jsonDecoder.decode(ResponseSchema.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError()))
                }
                
            } else if let error {
                completion(.failure(.invalidResponse()))
            }
        }
        task.resume()
    }
}
