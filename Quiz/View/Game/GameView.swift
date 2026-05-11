//
//  GameView.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI
import SwiftData

struct GameView<ViewModel>: View where ViewModel: GameViewModelProtocol {
    @StateObject var viewModel: ViewModel
    @State var showAlert: Bool = false
    @EnvironmentObject var navigation: NavigationState
    var large: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            switch viewModel.gameStatus {
            case .gameStarted, .gameEnded: EmptyView()
            case .finale, .showingFinalQuestion:
                Text("Final")
                    .font(large ? .externalLargeTitle : .title)
                    .padding(.horizontal)
            case .answeringQuestion, .choosingCategory:
                Text("Team \(viewModel.currentTeamName) ist dran")
                    .font(large ? .externalLargeTitle : .title)
                    .padding(.horizontal)
            }

            switch viewModel.gameStatus {
            case .gameStarted:
                Text("Game started")
            case .gameEnded:
                GameEndView(nameTeamA: viewModel.nameTeamA,
                            scoreTeamA: viewModel.scoreTeamA,
                            nameTeamB: viewModel.nameTeamB,
                            scoreTeamB: viewModel.scoreTeamB,
                            large: large)
            case .choosingCategory(let categories):
                CategoriesView(categories: categories, selectedCategoryIndex: $viewModel.selectedCategoryIndex, large: large)
                    .padding(.horizontal)
            case .answeringQuestion(let question):
                AnsweringQuestionView(selectedAnswer: $viewModel.selectedAnswer,
                                      correctAnswer: viewModel.correctAnswer,
                                      question: question,
                                      large: large)
                .padding(.bottom)
            case .finale(let category):
                FinaleView(category: category,
                           scoreTeamA: viewModel.scoreTeamA,
                           scoreTeamB: viewModel.scoreTeamB,
                           nameTeamA: viewModel.nameTeamA,
                           nameTeamB: viewModel.nameTeamB,
                           betTeamA: $viewModel.betTeamA,
                           betTeamB: $viewModel.betTeamB,
                           large: large)
            case .showingFinalQuestion(let finalQuestion):
                if large {
                    AnsweringQuestionView(selectedAnswer: .constant(nil), correctAnswer: nil, question: finalQuestion, large: true)
                } else {
                    FinalQuestionView(answerTeamA: $viewModel.finalAnswerTeamA,
                                      answerTeamB: $viewModel.finalAnswerTeamB,
                                      correctAnswer: viewModel.correctAnswer,
                                      question: finalQuestion,
                                      nameTeamA: viewModel.nameTeamA,
                                      nameTeamB: viewModel.nameTeamB,
                                      large: false
                    )
                }
            }
        }
        Spacer()
        if case .gameEnded = viewModel.gameStatus { EmptyView() } else {
            HStack(alignment: .top) {
                ScoreView(
                    nameTeamA: viewModel.nameTeamA,
                    scoreTeamA: viewModel.scoreTeamA,
                    nameTeamB: viewModel.nameTeamB,
                    scoreTeamB: viewModel.scoreTeamB,
                    large: large)

                Spacer()

                if case .showingFinalQuestion = viewModel.gameStatus {
                    CountDownView(remainingSeconds: viewModel.remainingSeconds, large: large)
                }
            }
            .padding()
        }

        if !large {
            Spacer()
            HStack {
                Button("Spiel beenden", role: .destructive) {
                    showAlert = true
                }

                Button("Auflösen") {
                    viewModel.answer()
                }
                .disabled(!viewModel.showAnswerButton)

                Button("Weiter") {
                    withAnimation {
                        viewModel.next()
                    }
                }
                .disabled(!viewModel.showNextButton)
            }
            .buttonStyle(.glassProminent)
            .alert("Spiel beenden?", isPresented: $showAlert, actions: {
                Button("Ja", role: .destructive) {
                    viewModel.endGame()
                    navigation.popToHome()
                }
                Button("Nein", role: .cancel) { }
            })
        }
    }
}

#Preview {
    GameView(viewModel: MockGameViewModel(gameStatus: .showingFinalQuestion(question: QuestionSet.example.finalQuestion)), large: false)
}
