//
//  CorrectAnswerPicker.swift
//  Quiz
//
//  Created by Jakob Handke on 23.04.26.
//

import SwiftUI

struct CorrectAnswerPicker: View {
    @Bindable var question: Question

    var body: some View {
        Picker(selection: $question.correctAnswerUUID) {
            ForEach(question.answers) { answer in
                Text(answer.text)
                    .tag(answer.uuid, includeOptional: true)
            }
            if question.correctAnswerUUID == nil {
                Text("")
                    .tag(nil as UUID?)
            }
        } label: {
            Text("Korrekte Antwort")
        }
        .disabled(question.answers.isEmpty)
    }
}

#Preview {
    @Previewable @State var question: Question = QuestionSet.example.finalQuestion
    CorrectAnswerPicker(question: question)
}
