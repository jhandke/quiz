//
//  SelectAnswerView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.05.26.
//

import SwiftUI

struct SelectAnswerView: View {
    @Binding var selectedAnswer: Answer?
    var correctAnswer: Answer?
    let answers: [Answer]
    let large: Bool
    var showAnswerText: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(zip(answers.indices, answers)), id: \.0) { index, answer in
                HStack {
                    Text(index.capitalASCIILetter)
                        .font(large ? .externalLargeTitle : .title2)
                        .fontWeight(.bold)
                        .padding(.leading, large ? 20 : 8)
                        .padding(.trailing, large ? 32 : 8)
                    if showAnswerText {
                        Text(answer.text)
                            .font(large ? .externalBody : .default)
                    }
                }
                .padding(16)
                .frame(maxWidth: showAnswerText ? .infinity : 80, alignment: showAnswerText ? .leading : .center)
                .background {
                    if correctAnswer == answer {
                        return RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color.green.gradient)
                    } else if selectedAnswer == answer && correctAnswer != nil && correctAnswer != answer {
                        return RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color.red.gradient)
                    } else if selectedAnswer == answer {
                        return RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color.yellow.gradient)
                    } else {
                        return RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color.blue.opacity(0.5).gradient)
                    }
                }
                .onTapGesture {
                    if correctAnswer != nil { return }
                    selectedAnswer = answer
                }
                .padding(.bottom, large ? 8 : 0)
            }
        }
        .animation(.snappy, value: selectedAnswer)
        .animation(.snappy, value: correctAnswer)
    }
}

#Preview {
    @Previewable @State var answer: Answer?
    let answers = QuestionSet.example.finalQuestion.answers

    SelectAnswerView(selectedAnswer: $answer, correctAnswer: nil, answers: answers, large: false, showAnswerText: true)
}
