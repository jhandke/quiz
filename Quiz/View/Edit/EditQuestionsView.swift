//
//  EditQuestionsView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.03.26.
//

import SwiftUI
import SwiftData

struct EditQuestionsView: View {
    @Bindable var questionSet: QuestionSet
    @Environment(\.modelContext) var modelContext

    @Binding var selectedQuestion: Question?

    var body: some View {
        List(selection: $selectedQuestion) {
            Section("Name") {
                TextField("Namen eingeben", text: $questionSet.name)
            }
            .selectionDisabled()
            Section("Fragen") {
                ForEach($questionSet.questions) { $question in
                    NavigationLink(value: question) {
                        Text(question.text)
                    }
                    .swipeActions {
                        Button("Frage löschen", systemImage: "trash", role: .destructive) {
                            if selectedQuestion != nil, selectedQuestion == question {
                                withAnimation {
                                    selectedQuestion = nil
                                }
                            }
                            withAnimation {
                                modelContext.delete(question)
                                try? modelContext.save()
                            }
                        }
                    }
                }
                if questionSet.questions.isEmpty {
                    Text("Keine Fragen vorhanden.")
                }
            }
            Section("Finalfrage") {
                NavigationLink(value: questionSet.finalQuestion) {
                    Text(questionSet.finalQuestion.text)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Fragenkatalog bearbeiten")
        .toolbar {
            Button("Neue Frage", systemImage: "plus") {
                let question = Question(text: "Neue Frage", category: "", answers: [], correctAnswerUUID: nil)
                modelContext.insert(question)
                try? modelContext.save()
                withAnimation {
                    questionSet.questions.append(question)
                    try? modelContext.save()
                    selectedQuestion = question
                }
            }
            .animation(.default, value: questionSet.questions)
        }
        .onDisappear {
            try? modelContext.save()
        }
    }
}

#Preview {
    @Previewable @State var questionSet = QuestionSet.example
    @Previewable @State var selectedQuestion: Question?

    NavigationStack {
        EditQuestionsView(questionSet: questionSet, selectedQuestion: $selectedQuestion)
    }
}
