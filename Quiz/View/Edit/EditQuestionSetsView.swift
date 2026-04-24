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
    @Query(sort: \QuestionSet.name) var questionSets: [QuestionSet]
    
    @State private var showAlert = false
    @State private var newName = ""

    var body: some View {
        List(questionSets) { questionSet in
            NavigationLink(destination: EditQuestionsView(questionSet: questionSet)) {
                Text(questionSet.name)
            }
        }
        .navigationTitle("Fragenkataloge")
        .toolbar {
            Button("Beispielfragen hinzufügen", systemImage: "book.badge.plus") {
                let newQuestionSet = QuestionSet.example
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
//        .onDisappear {
//            do {
//                try modelContext.save()
//                print("EQSV modelContext.save() done")
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }

    private func addQuestionSet(name: String) {
        let newQuestionSet = QuestionSet(name: name, questions: [])
        modelContext.insert(newQuestionSet)
        //        viewModel.questionSets.append(.init(name: newName, questions: []))
        do {
            try modelContext.save()
            print("Saved")
        } catch {
            print(error.localizedDescription)
        }
        self.newName = ""
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionSet.self, configurations: config)
    container.mainContext.insert(QuestionSet.example)

    return NavigationStack {
        EditQuestionSetsView()
            .modelContainer(container)
    }
}
