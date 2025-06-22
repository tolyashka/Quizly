//
//  QuizResult+CoreDataClass.swift
//  Quizly
//
//  Created by Анатолий Лушников on 21.06.2025.
//

import Foundation
import CoreData

@objc(QuizResult)
public class QuizResult: NSManagedObject {}

extension QuizResult: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizResult> {
        return NSFetchRequest<QuizResult>(entityName: "QuizResult")
    }

    @NSManaged public var date: Date
    @NSManaged public var percent: Double
    @NSManaged public var score: Int32
    @NSManaged public var total: Int32
    @NSManaged public var configurator: QuestionConfiguration?
}
