//
//  CoreDataClass2.swift
//  Quizly
//
//  Created by Анатолий Лушников on 17.06.2025.
//

import Foundation
import CoreData

protocol IQuestionConfigService {
    func saveConfig(_ config: QuestionConfigModel)
    func getActiveConfigID() -> UUID?
    func setActiveConfigID(_ id: UUID)
    func fetchConfig(by id: UUID) -> QuestionConfiguration?
}

final class QuestionConfigService: IQuestionConfigService {
    private let context = PersistantContainerStorage.persistentContainer.viewContext
    private let configuratorManager: IConfiguratorManager
    
    init(configuratorManager: IConfiguratorManager) {
        self.configuratorManager = configuratorManager
    }

    func saveConfig(_ config: QuestionConfigModel) {
        let request: NSFetchRequest<QuestionConfiguration> = QuestionConfiguration.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", config.id as CVarArg)
        request.fetchLimit = 1

        do {
            let entity = try context.fetch(request).first ?? QuestionConfiguration(context: context)
            entity.id = config.id
            entity.title = config.title
            entity.difficultyLevel = config.difficultyLevel
            entity.countQuestions = config.countQuestions
            entity.answersType = config.answerType
            try context.save()
        } catch { }
    }

    func fetchConfig(by id: UUID) -> QuestionConfiguration? {
        let request: NSFetchRequest<QuestionConfiguration> = QuestionConfiguration.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }
    
    func setActiveConfigID(_ id: UUID) {
        configuratorManager.setActiveConfigID(id)
    }

    func getActiveConfigID() -> UUID? {
        configuratorManager.getActiveConfigID()
    }
}
