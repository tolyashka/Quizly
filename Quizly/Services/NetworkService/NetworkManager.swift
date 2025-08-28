//
//  NetworkManager.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import Foundation

enum LoadState {
    case beingUploaded
    case uploaded
    case uploadWithError(Error)
}
protocol INetworkManager: AnyObject {
    func fetchQuestions(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (QuestionModel) -> Void
    )
    func createURLConfiguration(with configuration: [URLQueryItem]?)
}

final class NetworkManager: NSObject, INetworkManager {
    private typealias NetworkResult = Result<QuestionModel, NetworkError>
    
    private let networkClient: INetworkClient
    private let urlConfigurator: IURLConfigurator
    
    init(networkClient: INetworkClient,
         urlConfigurator: IURLConfigurator
    ) {
        self.networkClient = networkClient
        self.urlConfigurator = urlConfigurator
    }
    
    func createURLConfiguration(with configuration: [URLQueryItem]?) {
        urlConfigurator.updateURL(with: configuration)
    }
    
    func fetchQuestions(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (QuestionModel) -> Void
    ) {
        dataUploadingHandler(LoadState.beingUploaded)
        networkClient.get(url: urlConfigurator.url) { (result: NetworkResult) in
            dataUploadingHandler(LoadState.uploaded)
            switch result {
            case .success(let questionModel):
                completionHandler(questionModel)
            case .failure(let error):
                dataUploadingHandler(LoadState.uploadWithError(error))
            }
        }
    }
}
