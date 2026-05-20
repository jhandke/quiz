//
//  ModelContainerProvider.swift
//  Quiz
//
//  Created by Jakob Handke on 19.05.26.
//

import SwiftData

class ModelContainerProvider {
    static let shared: ModelContainer = {
        let schema = Schema(versionedSchema: SchemaV1.self)
        do {
            return try ModelContainer(
                for: schema,
                migrationPlan: MigrationPlan.self
            )
        } catch {
            fatalError("Migration failed: \(error)")
        }
    }()
}
