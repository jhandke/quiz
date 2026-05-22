//
//  SelectGameView.swift
//  Quiz
//
//  Created by Jakob Handke on 07.03.26.
//

import SwiftUI
import SwiftData

struct SelectGameView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \QuestionSet.lastEdit, order: .reverse) var questionSets: [QuestionSet]

    @EnvironmentObject private var navigation: NavigationState

    var body: some View {
        if questionSets.isEmpty {
            ContentUnavailableView("Keine Fragensätze gefunden", systemImage: "exclamationmark.triangle")
        } else {
            List(questionSets) { questionSet in
                NavigationLink(value: questionSet) {
                    Text(questionSet.name)
                }
                .disabled(questionSet.questions.count != 12)
            }
            .navigationTitle("Fragensatz auswählen")
            .navigationDestination(for: QuestionSet.self) { questionSet in
                PrepareGameView(questionSet: questionSet)
                    .environmentObject(navigation)
            }
        }
    }
}

#Preview {
    @Previewable @State var navigation = NavigationState()
    let container = ModelContainerProvider.preview
    container.mainContext.insert(QuestionSet.example)

    return NavigationStack {
        SelectGameView()
            .modelContainer(container)
            .environmentObject(navigation)
    }
}
