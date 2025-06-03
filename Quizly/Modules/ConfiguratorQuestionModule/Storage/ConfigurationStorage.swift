//
//  QuestionConfigurationStorage.swift
//  Quizly
//
//  Created by Анатолий Лушников on 31.05.2025.
//

import Foundation

enum StorageIdentifier: String, Codable {
    case selectedItems
}

protocol IConfigurationStorage: AnyObject {
    func save<StoredType: Codable>(storedValue: StoredType, for key: StorageIdentifier)
    func get<StoredType: Codable>(type: StoredType.Type, forKey key: StorageIdentifier) -> StoredType?
}

final class ConfigurationStorage: IConfigurationStorage {
    static let shared = ConfigurationStorage()
    
    private let userDefaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() { }
    
    func save<StoredType: Codable>(storedValue: StoredType, for key: StorageIdentifier) {
        guard let encodeData = try? encoder.encode(storedValue) else { return }
        userDefaults.set(encodeData, forKey: key.rawValue)
    }
    
    func get<StoredType: Codable>(type: StoredType.Type, forKey key: StorageIdentifier) -> StoredType? {
        guard let storedData = userDefaults.data(forKey: key.rawValue) else { return nil }
        let decodeData = try? decoder.decode(type.self, from: storedData)
        return decodeData
    }
}
