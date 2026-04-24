//
//  SelectGameView.swift
//  Quiz
//
//  Created by Jakob Handke on 07.03.26.
//

import SwiftUI
import SwiftData

struct SelectGameView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var questionSets: [QuestionSet]

    var body: some View {
        List(questionSets) { questionSet in
            NavigationLink {
                GameView(questionSet: questionSet)
                    .navigationBarBackButtonHidden()
                    .navigationTitle(questionSet.name)
            } label: {
                Text(questionSet.name)
            }
        }
        .navigationTitle("Spiel auswählen")
        .onDisappear {
            modelContext.processPendingChanges()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionSet.self , configurations: config)
    container.mainContext.insert(QuestionSet.example)

    return NavigationStack {
        SelectGameView()
    }
    .modelContainer(container)
}
