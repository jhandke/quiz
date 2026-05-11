//
//  FinalQuestionView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.05.26.
//

import SwiftUI

struct FinalQuestionView: View {
    @Binding var answerTeamA: Answer?
    @Binding var answerTeamB: Answer?
    var correctAnswer: Answer?
    let question: Question
    let nameTeamA: String
    let nameTeamB: String
    let large: Bool

    var body: some View {
        VStack {
            QuestionView(question: question, large: false)
                .padding(.bottom)
            HStack {
                VStack(alignment: .leading) {
                    Text("Team \(nameTeamA):")
                        .font(.title2)
                        .padding(.horizontal)
                    SelectAnswerView(selectedAnswer: $answerTeamA, correctAnswer: correctAnswer, answers: question.answers, large: large)
                }
                VStack(alignment: .leading) {
                    Text("Team \(nameTeamB):")
                        .font(.title2)
                        .padding(.horizontal)
                    SelectAnswerView(selectedAnswer: $answerTeamB, correctAnswer: correctAnswer, answers: question.answers, large: large)
                }
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var answerTeamA: Answer?
    @Previewable @State var answerTeamB: Answer?
    let question = QuestionSet.example.finalQuestion

    FinalQuestionView(
        answerTeamA: $answerTeamA,
        answerTeamB: $answerTeamB,
        correctAnswer: nil,
        question: question,
        nameTeamA: "A",
        nameTeamB: "B",
        large: false
    )
}
