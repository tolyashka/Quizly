//
//  NetworkManager.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

protocol INetworkManager: AnyObject {
    func fetchQuestions(
        completionHandler: @escaping (QuestionModel) -> Void
    )
    func createURLConfiguration(with configuration: [QueryItem]?)
}

final class NetworkManager: INetworkManager {
    private typealias NetworkResult = Result<QuestionModel, NetworkError>
    
    private let networkClient: INetworkClient
    private let urlConfigurator: IURLConfigurator
    
    init(networkClient: INetworkClient,
         urlConfigurator: IURLConfigurator
    ) {
        self.networkClient = networkClient
        self.urlConfigurator = urlConfigurator
    }
    
    func createURLConfiguration(with configuration: [QueryItem]?) {
        urlConfigurator.updateURL(with: configuration)
    }
    
    func fetchQuestions(completionHandler: @escaping (QuestionModel) -> Void) {
        networkClient.get(url: urlConfigurator.url) { (result: NetworkResult) in
            switch result {
            case .success(let questionModel):
                completionHandler(questionModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
