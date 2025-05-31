//
//  QuestionConfigurationStorage.swift
//  Quizly
//
//  Created by Анатолий Лушников on 31.05.2025.
//

import Foundation

final class ConfigurationStorage {
    static let shared = ConfigurationStorage()
    
    private let userDefaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() { }
    
    func save<StoredType: Codable>(storedValue: StoredType, for key: String) {
        guard let encodeData = try? encoder.encode(storedValue) else { return }
        userDefaults.set(encodeData, forKey: key)
    }
    
    func get<StoredType: Codable>(type: StoredType.Type, forKey key: String) -> StoredType? {
        guard let storedData = userDefaults.data(forKey: key) else { return nil }
        let decodeData = try? decoder.decode(type.self, from: storedData)
        return decodeData
    }
}
