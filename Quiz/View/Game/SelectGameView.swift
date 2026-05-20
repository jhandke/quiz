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
            let container = ModelContainerProvider.shared
            self.modelContext = ModelContext(container)
            self.modelContext.autosaveEnabled = false
        }

        func getQuestionSets() throws -> [QuestionSet] {
            return try modelContext.fetch(FetchDescriptor<QuestionSet>())
        }
    }
}

#Preview {
    let container = ModelContainerProvider.preview
    container.mainContext
        .insert(
            GameInstance(
                questions: QuestionSet.example.questions,
                questionSetName: QuestionSet.example.name,
                nameTeamA: "A",
                nameTeamB: "B",
                scoreTeamA: 0,
                scoreTeamB: 0,
                currentTurnRaw: "teamA",
                selectedQuestion: nil,
                givenAnswers: [],
                finalBetTeamA: 0,
                finalBetTeamB: 0,
                finalAnswerTeamA: nil,
                finalAnswerTeamB: nil,
                finalQuestion: QuestionSet.example.finalQuestion
            )
        )

    return NavigationStack {
        SelectGameView()
            .modelContainer(container)
    }
}
