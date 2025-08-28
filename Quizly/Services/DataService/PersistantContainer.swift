//
//  File.swift
//  Quizly
//
//  Created by Анатолий Лушников on 21.06.2025.
//

import Foundation
import CoreData

enum PersistantContainerStorage {
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "QuizGameModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error creating persistent container: \(error)")
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
                print("Error saving context: \(nserror)")
            }
        }
    }
}

