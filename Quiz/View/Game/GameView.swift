//
//  GameView.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI

struct GameView: View {
    @State var viewModel: GameViewModel
    @State var showAlert: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            QuestionView(selectedAnswer: $viewModel.selectedAnswer, correctAnswer: $viewModel.correctAnswer, question: viewModel.currentQuestion)
            .padding(.bottom)

            Spacer()

            HStack {
                Button("Spiel beenden", role: .destructive) {
                    showAlert = true
                }

                Button("Auflösen") {
                    viewModel.checkAnswer()
                }
                .disabled(viewModel.selectedAnswer == nil || viewModel.correctAnswer != nil)

                Button("Weiter") {
                    viewModel.advanceGameState()
                }
                .disabled(viewModel.correctAnswer == nil)
            }
            .buttonStyle(.glassProminent)
        }
        .alert("Spiel beenden?", isPresented: $showAlert, actions: {
            Button("Ja", role: .destructive) {
                viewModel.endGame()
                dismiss()
            }
            Button("Nein", role: .cancel) { }
        })
        .onAppear() {
            viewModel.start()
        }
    }

    init(questionSet: QuestionSet) {
        print("GameView::init")
        self.viewModel = .init(questionSet: questionSet)
    }
}

#Preview {
    GameView(questionSet: QuestionSet.example)
}
