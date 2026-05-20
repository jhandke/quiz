//
//  EditQuestionAnswersView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.03.26.
//

import SwiftUI
import SwiftData

struct EditQuestionAnswersView: View {
    @Bindable var question: Question
    @Environment(\.modelContext) var modelContext

    @Query var answers: [Answer]

    init(question: Question) {
        let predicate = #Predicate<Answer> { answer in
            if let questionID = answer.question?.id {
                return question.id == questionID
            } else {
                return false
            }
        }

        self._answers = Query(filter: predicate, sort: \.createdAt)
        self.question = question
    }

    var body: some View {
        List {
            Section("Frage") {
                TextField("Fragentext eingeben", text: $question.text, axis: .vertical)
                    .onMultilineSubmit(in: $question.text, submitLabel: .done) {
                        try? modelContext.save()
                    }
            }
            Section("Kategorie") {
                TextField("Kategorie eingeben", text: $question.category)
                    .onMultilineSubmit(in: $question.category, submitLabel: .done) {
                        try? modelContext.save()
                    }
            }
            Section("Antworten") {
                ForEach(answers) { answer in
                    answerCard(for: Bindable(answer))
                }
                if answers.count < 3 {
                    addAnswerButton
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Frage bearbeiten")
        .onDisappear {
            try? modelContext.save()
        }
    }

    @ViewBuilder
    private func answerCard(for answer: Bindable<Answer>) -> some View {
        HStack {
            TextField("Antworttext eingeben", text: answer.text, axis: .vertical)
                .onMultilineSubmit(in: answer.text, submitLabel: .done) {
                    try? modelContext.save()
                }
            Spacer()
            if question.correctAnswerUUID == answer.wrappedValue.uuid {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(.green)
            } else {
                Image(systemName: "x.circle")
                    .foregroundStyle(.red)
                    .onTapGesture {
                        withAnimation {
                            question.correctAnswerUUID = answer.wrappedValue.uuid
                            try? modelContext.save()
                        }
                    }
            }
        }
        .swipeActions {
            Button(role: .destructive) {
                withAnimation {
                    modelContext.delete(answer.wrappedValue)
                    try? modelContext.save()
                    question.fixCorrectAnswer()
                }
            } label: {
                Label("Antwort löschen", systemImage: "trash")
            }
        }
    }

    private var addAnswerButton: some View {
        Button("Neue Antwort hinzufügen") {
            let newAnswer = Answer(text: "Neue Antwort")
            withAnimation {
                modelContext.insert(newAnswer)
                try? modelContext.save()
                question.addAnswer(newAnswer)
            }
        }
    }
}

#Preview {
    @Previewable @State var question: Question = QuestionSet.example.questions.first!

    NavigationStack {
        EditQuestionAnswersView(question: question)
    }
}
