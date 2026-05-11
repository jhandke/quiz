//
//  QuestionView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.05.26.
//

import SwiftUI

struct QuestionView: View {
    var question: Question
    var large: Bool

    var body: some View {
        Text(question.text)
            .font(large ? .externalBody : Font.title3)
            .padding()
            .padding(.leading, large ? 20 : 8)
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.blue.opacity(0.6).gradient, in: RoundedRectangle(cornerRadius: 12))
            .padding(.bottom, large ? 16 : 4)
    }
}

#Preview {
    QuestionView(question: QuestionSet.example.finalQuestion, large: false)
}
