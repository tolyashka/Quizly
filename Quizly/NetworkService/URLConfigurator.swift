//
//  URLConfigurator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import Foundation

protocol IURLConfigurator: AnyObject {
//    func updateURL(with string: String)
    func createURL(with urlString: String, queryConfiguration: [QueryItem]) -> URL?
}

class URLConfigurator: IURLConfigurator, AnyObject {
//    private var urlString: String
    
//    init(mainURL: String) {
//        self.urlString = mainURL
//    }
//    
//    func updateURL(with string: String) {
//        self.urlString = string
//    }
    
    func createURL(with urlString: String, queryConfiguration: [QueryItem]) -> URL? {
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        
        urlComponents.queryItems = queryConfiguration.map {
            URLQueryItem(name: $0.name, value: $0.value)
        }
        
        return urlComponents.url
    }
    
}
