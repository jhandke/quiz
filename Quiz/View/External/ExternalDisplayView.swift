//
//  ExternalDisplayView.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI

struct ExternalDisplayView: View {
    @State var viewModel = NewExternalDisplayViewModel()
    @State var quizState = QuizState.shared

    private let fontSize = ScreenStatus.shared.idealFontSize

    var body: some View {
        if viewModel.gameAvailable {
            if let currentQuestion = viewModel.currentQuestion {
                QuestionView(
                    selectedAnswer: .constant(viewModel.selectedAnswer),
                    correctAnswer: .constant(viewModel.correctAnswer),
                    question: viewModel.currentQuestion,
                    large: true,
                    largeFontSize: fontSize
                )
            } else {
                Text("Quiz")
                    .font(.system(size: fontSize))
            }
        }
    }
}

#Preview {
    ExternalDisplayView()
}
