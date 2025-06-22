//
//  HistoryPageViewData.swift
//  Quizly
//
//  Created by Анатолий Лушников on 15.06.2025.
//

import Foundation

protocol IConfiguratorManager {
    func setActiveConfigID(_ id: UUID)
    func getActiveConfigID() -> UUID?
}

final class ConfiguratorManager: IConfiguratorManager {
    private var activeConfigID: UUID?

    func setActiveConfigID(_ id: UUID) {
        self.activeConfigID = id
    }

    func getActiveConfigID() -> UUID? {
        return activeConfigID
    }
}
