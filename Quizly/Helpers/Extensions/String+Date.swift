//
//  Date+extensions.swift
//  Quizly
//
//  Created by Анатолий Лушников on 28.08.2025.
//

import Foundation

extension Date {
    func toString(format: String = "dd-MM-yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}
