//
//  QuestionConfigurationNotificationCenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 15.08.2025.
//

import Foundation

fileprivate enum UserInfoKey: String {
    case value
}

struct Event<T> {
    let name: Notification.Name
}

extension Event {
    static var userDidSelectItem: Event<[QuestionItemViewModel]> {
        Event<[QuestionItemViewModel]>(name: Notification.Name("userDidSelectItem"))
    }
}

protocol QuestionConfigurationEvent: AnyObject {
    func post<T>(_ event: Event<T>, value: T)
    func observe<T>(_ event: Event<T>, block: @escaping (T) -> Void) -> NSObjectProtocol
    func removeObserve(with token: NSObjectProtocol)
}

final class ConfigurationNotificationCenter: QuestionConfigurationEvent {
    private let notificationCenter = NotificationCenter.default
    
    func post<T>(_ event: Event<T>, value: T) {
        notificationCenter.post(name: event.name, object: nil, userInfo: [UserInfoKey.value.rawValue: value])
    }
    
    func observe<T>(_ event: Event<T>, block: @escaping (T) -> Void) -> NSObjectProtocol {
        return notificationCenter.addObserver(forName: event.name, object: nil, queue: .main) { notification in
            if let value = notification.userInfo?[UserInfoKey.value.rawValue] as? T {
                block(value)
            }
        }
    }
    
    func removeObserve(with token: NSObjectProtocol) {
        notificationCenter.removeObserver(token)
    }
}
