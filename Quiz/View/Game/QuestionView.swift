//
//  QuestionView.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI

struct QuestionView: View {
    @Binding var selectedAnswer: Answer?
    @Binding var correctAnswer: Answer?
    let question: Question?
    var large: Bool = false
    var largeFontSize: CGFloat = 96

    var body: some View {
        VStack(alignment: .leading) {
            if let question {
                Text(question.text)
                    .font(large ? .system(size: largeFontSize) : Font.title3)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.blue.opacity(0.6).gradient, in: RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, large ? 16 : 4)
                //                .glassEffect(.regular.tint(.blue.opacity(0.6)), in: RoundedRectangle(cornerRadius: 12))
                ForEach(Array(zip(question.answers.indices, question.answers)), id: \.0) { index, answer in
                    HStack {
                        Text(indexToLetter(index))
                            .font(large ? .system(size: largeFontSize) : Font.title2)
                            .fontWeight(.bold)
                            .padding(.trailing, large ? 32 : 8)
                        Text(answer.text)
                            .font(large ? .system(size: largeFontSize) : .default)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        correctAnswer == answer ? Color.green.gradient : selectedAnswer == answer ? Color.yellow.gradient : Color.blue
                            .opacity(0.5).gradient,
                        in: RoundedRectangle(cornerRadius: 12)
                    )
                    .onTapGesture {
                        if correctAnswer != nil { return }
                        selectedAnswer = answer
                    }
                    .padding(.bottom, large ? 8 : 0)
                }
            }
        }
        .animation(.snappy, value: selectedAnswer)
        .animation(.snappy, value: correctAnswer)
        .frame(maxWidth: .infinity)
        .padding()
    }

private func indexToLetter(_ index: Int) -> String {
    "\(UnicodeScalar(65 + index).map(Character.init) ?? "?")"
}
}

#Preview {
    @Previewable @State var selectedAnswer: Answer?
    @Previewable @State var correctAnswer: Answer?
    QuestionView(selectedAnswer: $selectedAnswer, correctAnswer: $correctAnswer, question: QuestionSet.example.questions.first!, large: false, largeFontSize: 140)
}
