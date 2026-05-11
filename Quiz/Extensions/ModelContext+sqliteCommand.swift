//
//  ModelContext+sqliteCommand.swift
//  Quiz
//
//  Created by Jakob Handke on 28.04.26.
//

// Stolen from https://www.hackingwithswift.com/quick-start/swiftdata/how-to-read-the-contents-of-a-swiftdata-database-store

import Foundation
import SwiftData

#if DEBUG
extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
#endif
