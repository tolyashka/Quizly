//
//  URLConfigurator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import Foundation

protocol IURLConfigurator: AnyObject {
    var url: URL?{ get }
    
    func updateURL(with queryConfiguration: [QueryItem]?)
    func switchURL(with urlString: String)
}

final class URLConfigurator: IURLConfigurator, AnyObject {
    private(set) var url: URL?
    private var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func switchURL(with urlString: String) {
        self.urlString = urlString
    }
    
    func updateURL(with queryConfiguration: [QueryItem]?) {
        guard var urlComponents = URLComponents(string: urlString) else {
            return
        }
        
        urlComponents.queryItems = queryConfiguration?.compactMap {
            URLQueryItem(name: $0.name, value: $0.value)
        }
        
        url = urlComponents.url
    }
}
