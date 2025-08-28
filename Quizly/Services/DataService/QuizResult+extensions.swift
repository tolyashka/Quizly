//
//  QuizResult+extensions.swift
//  Quizly
//
//  Created by Анатолий Лушников on 23.08.2025.
//

import Foundation
import CoreData

extension QuizResult {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizResult> {
        return NSFetchRequest<QuizResult>(entityName: "QuizResult")
    }

    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var score: Int32
    @NSManaged public var questionsCount: Int32
    @NSManaged public var percent: Double
}

@objc(QuizResult)
public class QuizResult: NSManagedObject {}
