//
//  DataService.swift
//  Quizly
//
//  Created by Анатолий Лушников on 15.06.2025.
//

import UIKit
import CoreData

protocol IDataService: AnyObject {
    func setActiveConfig(_ configModel: QuestionConfigModel)
    func saveQuizResult(_ result: QuizResultModel)
    
    func fetchLatestResult() -> QuizResultModel?
    func deleteAllQuizResults()
    func deleteAllQuestionConfigs()
    func fetchAllQuestionConfigs() -> [QuestionConfigModel]
    func fetchQuizResults(forConfigWithID id: UUID) -> [QuizResultModel]
}

enum PersistantContainerStorage {
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "QuizGameModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Error to create persistent container: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error to save context: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

final class DataService: IDataService {
    private var currentConfigID: UUID?
    
    func setActiveConfig(_ configModel: QuestionConfigModel) {
        currentConfigID = configModel.id
        saveQuestionConfig(configModel)
    }
    
    private func saveQuestionConfig(_ config: QuestionConfigModel) {
        let context = PersistantContainerStorage.persistentContainer.viewContext
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
            PersistantContainerStorage.saveContext()
        } catch {
            print("❌ Ошибка при сохранении конфигурации: \(error)")
        }
    }
    
    func saveQuizResult(_ result: QuizResultModel) {
        guard let id = currentConfigID else {
            print("❌ Конфигурация не установлена. Сначала вызови setActiveConfig.")
            return
        }
        
        let context = PersistantContainerStorage.persistentContainer.viewContext
        let request: NSFetchRequest<QuestionConfiguration> = QuestionConfiguration.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        do {
            if let configEntity = try context.fetch(request).first {
                let entity = QuizResult(context: context)
                entity.date = result.date
                entity.score = Int32(result.score)
                entity.total = Int32(result.total)
                entity.percent = result.percent
                entity.configurator = configEntity
                PersistantContainerStorage.saveContext()
            } else {
                print("❌ Конфигурация с id \(id) не найдена")
            }
        } catch {
            print("❌ Ошибка при сохранении результата: \(error)")
        }
    }
    
    func fetchQuizResults(forConfigWithID id: UUID) -> [QuizResultModel] {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        let request: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        request.predicate = NSPredicate(format: "configurator.id == %@", id as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let results = try context.fetch(request)
            return results.map {
                QuizResultModel(
                    date: $0.date,
                    score: Int($0.score),
                    total: Int($0.total),
                    percent: $0.percent
                )
            }
        } catch {
            print("❌ Ошибка при загрузке результатов: \(error)")
            return []
        }
    }
    
    func deleteAllQuestionConfigs() {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        let request: NSFetchRequest<QuestionConfiguration> = QuestionConfiguration.fetchRequest()

        do {
            let configs = try context.fetch(request)
            for config in configs {
                if let results = config.results {
                    results.forEach { context.delete($0) }
                }
                context.delete(config)
            }
            PersistantContainerStorage.saveContext()
        } catch {
            print("❌ Ошибка при удалении всех конфигураций: \(error)")
        }
    }

    func deleteAllQuizResults() {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            results.forEach { context.delete($0) }
            PersistantContainerStorage.saveContext()
        } catch {
            print("❌ Ошибка при удалении результатов: \(error)")
        }
    }
    
    func fetchLatestResult() -> QuizResultModel? {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            if let latest = try context.fetch(fetchRequest).first {
                return QuizResultModel(
                    date: latest.date,
                    score: Int(latest.score),
                    total: Int(latest.total),
                    percent: latest.percent
                )
            }
        } catch {
            print("❌ Ошибка при получении последнего результата: \(error)")
        }
        return nil
    }
    
    func fetchAllQuestionConfigs() -> [QuestionConfigModel] {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        let request: NSFetchRequest<QuestionConfiguration> = QuestionConfiguration.fetchRequest()
        
        do {
            let configs = try context.fetch(request)
            return configs.map {
                QuestionConfigModel(
                    id: $0.id,
                    title: $0.title,
                    difficultyLevel: $0.difficultyLevel,
                    countQuestions: $0.countQuestions,
                    answerType: $0.answersType
                )
            }
        } catch {
            print("❌ Ошибка при загрузке конфигураций: \(error)")
            return []
        }
    }
}
