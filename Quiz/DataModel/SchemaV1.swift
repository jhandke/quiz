//
//  SchemaV1.swift
//  Quiz
//
//  Created by Jakob Handke on 19.05.26.
//

import Foundation
import SwiftData

typealias CurrentSchema = SchemaV1

enum SchemaV1: VersionedSchema {
    static let versionIdentifier = Schema.Version(1, 0, 0)
    static let models: [any PersistentModel.Type] = [
        SchemaV1.Answer.self,
        SchemaV1.GameInstance.self,
        SchemaV1.GivenAnswer.self,
        SchemaV1.Question.self,
        SchemaV1.QuestionSet.self
    ]
}
