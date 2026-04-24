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

    var body: some View {
        Form {
            Section("Name") {
                TextField("Namen eingeben", text: $questionSet.name)
            }
            Section("Fragen") {
                ForEach($questionSet.questions) { $question in
                    NavigationLink(destination: EditQuestionAnswersView(question: $question)) {
                        Text(question.text)
                    }
                    .swipeActions {
                        Button("Frage löschen", systemImage: "trash", role: .destructive) {
                            questionSet.questions.removeAll { $0.id == question.id }
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
            //            ToolbarItem(placement: .bottomBar) {
            Button("Neue Frage", systemImage: "plus") {
                let question = Question(text: "Neue Frage", category: "Empty", answers: [], correctAnswerIndex: -1)
                questionSet.questions.append(question)
            }
            //            }
            .animation(.default, value: questionSet.questions)
        }
        .onChange(of: questionSet) { oldValue, newValue in
            do {
                try questionSet.modelContext?.save()
                print("Saved question set.")
            } catch {
                print(#function, error.localizedDescription)
            }
        }
    }
}

#Preview {
    @Previewable @State var questionSet = QuestionSet(name: "Test", questions: [])

    NavigationStack {
        EditQuestionsView(questionSet: questionSet)
    }
}
