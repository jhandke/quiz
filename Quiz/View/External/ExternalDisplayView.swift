//
//  ExternalDisplayView.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI

struct ExternalDisplayView: View {
    @State var quizState = QuizState.shared

    var body: some View {
        switch quizState.game {
        case .noGame:
            Text("Quiz")
                .font(.externalLargeTitle)
        case .gameRunning(let viewModel):
            GameView(viewModel: viewModel, large: true)
        }
    }
}

#Preview {
    ExternalDisplayView()
}
