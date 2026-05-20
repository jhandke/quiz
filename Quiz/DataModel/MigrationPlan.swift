//
//  MigrationPlan.swift
//  Quiz
//
//  Created by Jakob Handke on 19.05.26.
//

import SwiftData

enum MigrationPlan: SchemaMigrationPlan {
    static let schemas: [any VersionedSchema.Type] = [SchemaV1.self]
    static let stages: [MigrationStage] = []
}
