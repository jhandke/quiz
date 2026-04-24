//
//  EditQuestionAnswersView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.03.26.
//

import SwiftUI
import SwiftData

enum FocusableAnswer: Hashable {
    case none
    case answer(Answer)
}

struct EditQuestionAnswersView: View {
    @Binding var question: Question

    @FocusState private var focusedAnswer: FocusableAnswer?

    var body: some View {
        Form {
            Section("Frage") {
                TextField("Fragentext eingeben", text: $question.text, axis: .vertical)
                //                    .lineLimit(2...10)
            }
            Section("Kategorie") {
                TextField("Kategorie eingeben", text: $question.category)
            }
            Section("Antworten") {
                ForEach(question.answers.indices, id: \.self) { i in
                    TextField("Antworttext eingeben", text: $question.answers[i].text, axis: .vertical)
                        .submitLabel(.done)
                        .focused($focusedAnswer, equals: .answer(question.answers[i]))
                        .onSubmit {
                            focusedAnswer = nil
                        }
                        .swipeActions {
                            Button("Löschen", systemImage: "trash", role: .destructive) {
                                question.answers.remove(at: i)
                                withAnimation {

                                }
                            }
                        }
                }
                Button("Neue Antwort hinzufügen") {
                    let newAnswer = Answer(text: "")
                    withAnimation {
                        question.answers.append(newAnswer)
                        focusedAnswer = .answer(newAnswer)
                    }
                }
                .disabled(self.question.answers.count >= 3)
            }

            Section("Einstellungen") {
                CorrectAnswerPicker(answers: question.answers, correctAnswerIndex: $question.correctAnswerIndex)
            }

        }
        .scrollDismissesKeyboard(.immediately)
        .navigationTitle("Frage bearbeiten")
    }
}

#Preview {
    @Previewable @State var question: Question = QuestionSet.example.questions.first!

    NavigationStack {
        EditQuestionAnswersView(question: $question)
    }
}
