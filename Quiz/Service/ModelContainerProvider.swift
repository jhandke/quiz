//
//  ModelContainerProvider.swift
//  Quiz
//
//  Created by Jakob Handke on 19.05.26.
//

import SwiftData
import Foundation

class ModelContainerProvider {
    static let shared: ModelContainer = {
        let schema = Schema(versionedSchema: SchemaV1.self)
        do {
            return try ModelContainer(
                for: schema,
                migrationPlan: MigrationPlan.self
            )
        } catch {
            fatalError("Failed to create model container: \(error.localizedDescription)")
        }
    }()

    static let preview: ModelContainer = {
        let schema = Schema(versionedSchema: SchemaV1.self)
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            return try ModelContainer(
                for: schema,
                migrationPlan: MigrationPlan.self,
                configurations: [configuration]
            )
        } catch {
            print("Failed to create model container for previews: \(error.localizedDescription)")
            fatalError("Creating model container for previews failed: \(error.localizedDescription)")
        }
    }()
}
