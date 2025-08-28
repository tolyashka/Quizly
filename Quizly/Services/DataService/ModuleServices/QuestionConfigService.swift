//
//  CoreDataClass2.swift
//  Quizly
//
//  Created by Анатолий Лушников on 17.06.2025.
//

import Foundation
import CoreData

protocol IDataService: AnyObject {
    func fetchResults() -> Result<[QuizResultModel], HistoryStorageError>
    func addResult(_ model: QuizResultModel)
    func updateResult(_ model: QuizResultModel) -> Result<Void, HistoryStorageError>
    func deleteResult(id: UUID) -> Result<Void, HistoryStorageError>
}

final class DataService: IDataService {
    private let context = PersistantContainerStorage.persistentContainer.viewContext
    
    // MARK: - Fetch
    func fetchResults() -> Result<[QuizResultModel], HistoryStorageError> {
        let request: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let results = try context.fetch(request)
            let models = results.compactMap {
                QuizResultModel(
                    id: $0.id,
                    date: $0.date,
                    score: Int($0.score),
                    questionsCount: Int($0.questionsCount),
                    percent: $0.percent
                )
            }
            return .success(models)
        } catch {
            return .failure(.fetchError)
        }
    }
    
    // MARK: - Add
    func addResult(_ model: QuizResultModel) {
        let newResult = QuizResult(context: context)
        newResult.id = model.id
        newResult.date = model.date
        newResult.score = Int32(model.score)
        newResult.questionsCount = Int32(model.questionsCount)
        newResult.percent = model.percent
        
        PersistantContainerStorage.saveContext()
    }
    
    // MARK: - Update
    func updateResult(_ model: QuizResultModel) -> Result<Void, HistoryStorageError> {
        guard let existing = getResult(with: model.id) else {
            return .failure(.fetchError)
        }
        existing.id = model.id
        existing.date = model.date
        existing.score = Int32(model.score)
        existing.questionsCount = Int32(model.questionsCount)
        existing.percent = model.percent
        
        PersistantContainerStorage.saveContext()
        return .success(())
    }
    
    // MARK: - Delete
    func deleteResult(id: UUID) -> Result<Void, HistoryStorageError> {
        guard let existing = getResult(with: id) else {
            return .failure(.fetchError)
        }
        context.delete(existing)
        PersistantContainerStorage.saveContext()
        return .success(())
    }
    
    // MARK: - Private
    private func getResult(with id: UUID?) -> QuizResult? {
        guard let id = id else { return nil }
        let request: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        return try? context.fetch(request).first
    }
}
