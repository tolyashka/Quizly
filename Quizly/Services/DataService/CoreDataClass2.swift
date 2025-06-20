//
//  CoreDataClass2.swift
//  Quizly
//
//  Created by Анатолий Лушников on 17.06.2025.
//

import Foundation
import CoreData

@objc(QuestionConfiguration)
public class QuestionConfiguration: NSManagedObject {}

extension QuestionConfiguration: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionConfiguration> {
        return NSFetchRequest<QuestionConfiguration>(entityName: "QuestionConfiguration")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var difficultyLevel: String
    @NSManaged public var countQuestions: Int32
    @NSManaged public var answersType: String

    @NSManaged public var results: Set<QuizResult>?
}
