//
//  CorrectAnswerPicker.swift
//  Quiz
//
//  Created by Jakob Handke on 23.04.26.
//

import SwiftUI

struct CorrectAnswerPicker: View {
    var answers: [Answer]
    @Binding var correctAnswerIndex: Int

    var body: some View {
        Picker(selection: $correctAnswerIndex) {
            ForEach(self.answers.indices, id: \.self) { index in
                Text(answers[index].text)
                    .tag(index)
            }
        } label: {
            Text("Korrekte Antwort")
        }
        .disabled(self.answers.isEmpty)
    }
}
