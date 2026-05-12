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

    @State private var selectedQuestionSet: QuestionSet?
    @State private var selectedQuestion: Question?

    var body: some View {
        NavigationSplitView {
            Group {
                if questionSets.isEmpty {
                    Button(action: addExampleQuestionSet) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Beispielfragen hinzufügen")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                } else {
                    List(questionSets, selection: $selectedQuestionSet) { questionSet in

                        NavigationLink(value: questionSet) {
                            VStack(alignment: .leading) {
                                Text(questionSet.name)
                                Text(questionSet.lastEdit, style: .date)
                                    .font(.caption)
                            }
                        }
                        .swipeActions {
                            Button("Fragensatz löschen", systemImage: "trash", role: .destructive) {
                                if let index = questionSets.firstIndex(of: questionSet) {
                                    if selectedQuestionSet != nil, selectedQuestionSet == questionSets[index] {
                                        withAnimation {
                                            selectedQuestionSet = nil
                                            selectedQuestion = nil
                                        }
                                    }
                                    modelContext.delete(questionSets[index])
                                }
                            }
                            modelContext.delete(questionSets[index])
                        }
                    }
                }
            }
            .navigationTitle("Fragenkataloge")
            .toolbar {
                Button("Neuer Fragenkatalog", systemImage: "plus") {
                    self.showAlert = true
                }
            }
            .navigationDestination(for: QuestionSet.self) { questionSet in
                EditQuestionsView(questionSet: questionSet, selectedQuestion: $selectedQuestion)
                    .navigationDestination(for: Question.self) { question in
                        EditQuestionAnswersView(question: question)
                    }
            }
        } content: {
            if let selectedQuestionSet {
                EditQuestionsView(questionSet: selectedQuestionSet, selectedQuestion: $selectedQuestion)
                    .navigationDestination(for: Question.self) { question in
                        EditQuestionAnswersView(question: question)
                    }
            } else {
                Text("Wähle einen Fragensatz aus")
            }
        } detail: {
            if let selectedQuestion {
                EditQuestionAnswersView(question: selectedQuestion)
            } else {
                Text("Wähle eine Frage aus")
            }
        }
        .navigationSplitViewStyle(.balanced)

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
    }

    private func addQuestionSet(name: String) {
        let isFirstQuestionSet = questionSets.isEmpty
        let newQuestionSet = QuestionSet(
            name: name,
            questions: [],
            finalQuestion: Question(text: "", category: "", answers: [], correctAnswerUUID: nil),
            lastEdit: Date.now
        )
        withAnimation {
            modelContext.insert(newQuestionSet)
            self.selectedQuestionSet = newQuestionSet
        }
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

    return
        EditQuestionSetsView()
            .modelContainer(container)

}
