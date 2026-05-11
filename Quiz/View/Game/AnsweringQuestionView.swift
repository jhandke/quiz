//
//  AnsweringQuestionView.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI

struct AnsweringQuestionView: View {
    @Binding var selectedAnswer: Answer?
    var correctAnswer: Answer?
    let question: Question
    let large: Bool

    var body: some View {
        VStack(alignment: .leading) {
            QuestionView(question: question, large: large)
            SelectAnswerView(selectedAnswer: $selectedAnswer, correctAnswer: correctAnswer, answers: question.answers, large: large)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var selectedAnswer: Answer?

    AnsweringQuestionView(
        selectedAnswer: $selectedAnswer,
        correctAnswer: nil,
        question: QuestionSet.example.questions.first!,
        large: false
    )
}
