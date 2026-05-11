//
//  EditQuestionSetsView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.03.26.
//

import SwiftUI
import SwiftData

struct EditQuestionSetsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \QuestionSet.lastEdit, order: .reverse) var questionSets: [QuestionSet]

    @State private var showAlert = false
    @State private var newName = ""

    var body: some View {
        List {
            ForEach(questionSets) { questionSet in
                NavigationLink(value: questionSet) {
                    VStack(alignment: .leading) {
                        Text(questionSet.name)
                        Text(questionSet.lastEdit, style: .date)
                            .font(.caption)
                    }
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    modelContext.delete(questionSets[index])
                }
                try? modelContext.save()
            }
        }
        .navigationTitle("Fragenkataloge")
        .toolbar {
            Button("Beispielfragen hinzufügen", systemImage: "book.badge.plus") {
                let newQuestionSet = QuestionSet.reduced
                modelContext.insert(newQuestionSet)
                try? modelContext.save()
            }
            Button("Neuer Fragenkatalog", systemImage: "plus") {
                self.showAlert = true
            }
        }
        .alert("Neuen Fragensatz erstellen", isPresented: $showAlert) {
            TextField("Namen eingeben", text: $newName)
            Button("Hinzufügen", role: .confirm, action: {
                addQuestionSet(name: newName)
            })
            .disabled(newName == "")
            Button("Abbrechen", role: .cancel) {
                self.showAlert = false
                self.newName = ""
            }
        }
        .task {
            modelContext.autosaveEnabled = true
        }
        .navigationDestination(for: QuestionSet.self) { questionSet in
            EditQuestionsView(questionSet: questionSet)
        }
    }

    private func addQuestionSet(name: String) {
        let newQuestionSet = QuestionSet(
            name: name,
            questions: [],
            finalQuestion: Question(text: "", category: "", answers: [], correctAnswerUUID: nil),
            lastEdit: Date.now
        )
        modelContext.insert(newQuestionSet)
        do {
            try modelContext.save()
            print(#file, #function, "Saved new question set.")
        } catch {
            print(error.localizedDescription)
        }
        self.newName = ""
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    // swiftlint:disable force_try
    let container = try! ModelContainer(for: QuestionSet.self, configurations: config)
    // swiftlint:enable force_try
    let questionSet = QuestionSet.example
    container.mainContext.insert(questionSet)
    let anotherQuestionSet = QuestionSet(
        name: questionSet.name + " 2",
        questions: questionSet.questions,
        finalQuestion: questionSet.finalQuestion,
        lastEdit: Date.now
    )
    container.mainContext.insert(anotherQuestionSet)

    return NavigationStack {
        EditQuestionSetsView()
            .modelContainer(container)
    }
}
