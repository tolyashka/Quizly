//
//  NetworkManager.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import Foundation

protocol INetworkManager: AnyObject {
    func fetchQuestions(
        completionHandler: @escaping (QuestionModel) -> Void
    )
}

class NetworkManager: INetworkManager {
    private typealias NetworkResult = Result<QuestionModel, NetworkError>
    
    private let networkClient: INetworkClient
    private let url: String
    
    init(networkClient: INetworkClient, url: String) {
        self.networkClient = networkClient
        self.url = url
    }
    
    func fetchQuestions(completionHandler: @escaping (QuestionModel) -> Void) {
        networkClient.get(urlString: url) { (result: NetworkResult) in
//            guard let self else { return }
            
            switch result {
            case .success(let questionModel):
                
                completionHandler(questionModel)
            case .failure(let error):
                print("Network manager error - ", error.localizedDescription)
            }
        }
    }
}
