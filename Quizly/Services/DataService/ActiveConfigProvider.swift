//
//  ActiveConfigProvider.swift
//  Quizly
//
//  Created by Анатолий Лушников on 21.06.2025.
//

import Foundation

protocol IActiveConfigProvider {
    func getActiveConfigID() -> UUID?
    func fetchConfig(by id: UUID) -> QuestionConfiguration?
}

final class ActiveConfigProvider: IActiveConfigProvider {
    private let configService: IQuestionConfigService

    init(configService: IQuestionConfigService) {
        self.configService = configService
    }

    func getActiveConfigID() -> UUID? {
        return configService.getActiveConfigID()
    }

    func fetchConfig(by id: UUID) -> QuestionConfiguration? {
        return configService.fetchConfig(by: id)
    }
}
