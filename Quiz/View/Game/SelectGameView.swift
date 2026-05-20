//
//  SelectGameView.swift
//  Quiz
//
//  Created by Jakob Handke on 07.03.26.
//

import SwiftUI
import SwiftData

struct SelectGameView: View {
    private var questionSets: [QuestionSet] = []
    var dataProvider: DataProvider?
    var error: Error?
    @EnvironmentObject private var navigation: NavigationState

    init() {
        do {
            try self.dataProvider = DataProvider()
            try self.questionSets = dataProvider?.getQuestionSets() ?? []
        } catch {
            print(#file, #function, error.localizedDescription)
            self.error = error
        }
    }

    var body: some View {
        if error == nil {
            List(questionSets) { questionSet in
                NavigationLink(value: questionSet) {
                    Text(questionSet.name)
                }
            }
            .navigationTitle("Fragensatz auswählen")
            .navigationDestination(for: QuestionSet.self) { questionSet in
                PrepareGameView(questionSet: questionSet)
                    .environmentObject(navigation)
            }
        } else {
            ContentUnavailableView("Fehler beim Laden der Fragensätze", systemImage: "exclamationmark.triangle")
        }
    }

    class DataProvider {
        let modelContext: ModelContext

        init() throws {
            print(#file, #function, "init")
            let schemaV1 = Schema(versionedSchema: SchemaV1.self)
            let container = try ModelContainer(for: schemaV1)
            self.modelContext = ModelContext(container)
            self.modelContext.autosaveEnabled = false
        }

        func getQuestionSets() throws -> [QuestionSet] {
            return try modelContext.fetch(FetchDescriptor<QuestionSet>())
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let schemaV1 = Schema(versionedSchema: SchemaV1.self)
    // swiftlint:disable force_try
    let container = try! ModelContainer(for: schemaV1, configurations: config)
    // swiftlint:enable force_try
    container.mainContext.insert(QuestionSet.example)

    return NavigationStack {
        SelectGameView()
            .modelContainer(container)
    }
}
