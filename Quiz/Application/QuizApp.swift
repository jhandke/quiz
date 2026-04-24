//
//  QuizApp.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI
import SwiftData

@main
struct QuizApp: App {
    var body: some Scene {
        WindowGroup {
            StartView()
                .modelContainer(for: QuestionSet.self)
        }
    }
}
