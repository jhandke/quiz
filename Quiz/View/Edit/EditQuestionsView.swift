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

    var body: some View {
        Form {
            Section("Name") {
                TextField("Namen eingeben", text: $questionSet.name)
            }
            Section("Fragen") {
                ForEach($questionSet.questions) { $question in
                    NavigationLink(value: question) {
                        Text(question.text)
                    }
                    .swipeActions {
                        Button("Frage löschen", systemImage: "trash", role: .destructive) {
                            if let index = questionSet.questions.firstIndex(of: question) {
                                questionSet.questions.remove(at: index)
                            }
                        }
                    }
                }
                if questionSet.questions.isEmpty {
                    Text("Keine Fragen vorhanden.")
                }
            }
        }
        .navigationTitle("Fragenkatalog bearbeiten")
        .toolbar {
            Button("Neue Frage", systemImage: "plus") {
                let question = Question(text: "Neue Frage", category: "", answers: [], correctAnswerUUID: nil)
                modelContext.insert(question)
                try? modelContext.save()
                withAnimation {
                    questionSet.questions.append(question)
                }
            }
            .animation(.default, value: questionSet.questions)
        }
        .navigationDestination(for: Question.self) { question in
            EditQuestionAnswersView(question: question)
        }
    }
}

#Preview {
    @Previewable @State var questionSet = QuestionSet(
        name: "Test",
        questions: [],
        finalQuestion: Question(text: "", category: "", answers: [], correctAnswerUUID: nil),
        lastEdit: Date.distantPast
    )

    NavigationStack {
        EditQuestionsView(questionSet: questionSet)
    }
}
