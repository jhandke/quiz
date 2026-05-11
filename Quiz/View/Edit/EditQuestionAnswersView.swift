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
    @Bindable var question: Question
    @Environment(\.modelContext) var modelContext

    @FocusState private var focusedAnswer: FocusableAnswer?
    @FocusState private var focusedText: Bool
    @FocusState private var focusedCategory: Bool

    var body: some View {
        Form {
            Section("Frage") {
                TextField("Fragentext eingeben", text: $question.text, axis: .vertical)
                    .multilineSubmit(for: $question.text, submitLabel: .done)
            }
            Section("Kategorie") {
                TextField("Kategorie eingeben", text: $question.category)
                    .multilineSubmit(for: $question.category, submitLabel: .done)
            }
            Section("Antworten") {
                ForEach(question.answers.indices, id: \.self) { index in
                    HStack {
                        TextField("Antworttext eingeben", text: $question.answers[index].text)
                            .submitLabel(.done)
                            .focused($focusedAnswer, equals: .answer(question.answers[index]))
                            .onSubmit {
                                focusedAnswer = nil
                            }
                        Spacer()
                        if question.correctAnswerUUID == question.answers[index].uuid {
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "x.circle")
                                .foregroundStyle(.red)
                                .onTapGesture {
                                    withAnimation {
                                        question.correctAnswerUUID = question.answers[index].uuid
                                    }
                                }
                        }
                    }
                }
                .onDelete(perform: question.removeAnswers)

                Button("Neue Antwort hinzufügen") {
                    let newAnswer = Answer(text: "Neue Antwort", uuid: UUID())
                    modelContext.insert(newAnswer)
                    try? modelContext.save()
                    withAnimation {
                        question.addAnswer(newAnswer)
                    }
                }
                .disabled(self.question.answers.count >= 3)
            }
        }

        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Frage bearbeiten")
    }
}

#Preview {
    @Previewable @State var question: Question = QuestionSet.example.questions.first!

    NavigationStack {
        EditQuestionAnswersView(question: question)
    }
}
