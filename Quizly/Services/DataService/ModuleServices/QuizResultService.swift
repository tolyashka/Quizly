//
//  DataManager.swift
//  Quizly
//
//  Created by Анатолий Лушников on 21.06.2025.
//

import Foundation
import CoreData
// FIXME: Сделать обработку ошибок
protocol IQuizResultService {
    func saveResult(_ result: QuizResultModel)
    func fetchAllSessions() -> [GameSession]
}

final class QuizResultService: IQuizResultService {
    private let context = PersistantContainerStorage.persistentContainer.viewContext
    private let configProvider: IActiveConfigProvider

    init(configProvider: IActiveConfigProvider) {
        self.configProvider = configProvider
    }

    func saveResult(_ result: QuizResultModel) {
        guard let configID = configProvider.getActiveConfigID(),
              let configEntity = configProvider.fetchConfig(by: configID) else {
            return
        }

        let entity = QuizResult(context: context)
        entity.date = result.date
        entity.score = Int32(result.score)
        entity.total = Int32(result.total)
        entity.percent = result.percent
        entity.configurator = configEntity

        do {
            try context.save()
        } catch { }
    }

    func fetchAllSessions() -> [GameSession] {
        let request: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        do {
            return try context.fetch(request)
                .compactMap { result in
                    guard let config = result.configurator else { return nil }

                    let configModel = QuestionConfigModel(
                        id: config.id,
                        title: config.title,
                        difficultyLevel: config.difficultyLevel,
                        countQuestions: config.countQuestions,
                        answerType: config.answersType
                    )

                    let resultModel = QuizResultModel(
                        date: result.date,
                        score: Int(result.score),
                        total: Int(result.total),
                        percent: result.percent
                    )

                    return GameSession(config: configModel, result: resultModel)
                }
                .sorted { $0.result.date > $1.result.date }
        } catch { return [] }
    }
}

