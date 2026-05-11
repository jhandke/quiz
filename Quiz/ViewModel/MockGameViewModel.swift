//
//  MockGameViewModel.swift
//  Quiz
//
//  Created by Jakob Handke on 10.05.26.
//

import Foundation
import Combine
import SwiftUI

final class MockGameViewModel: GameViewModelProtocol {
    private var timer: Timer?
    @Published var betTeamA: Int = 0
    @Published var betTeamB: Int = 0
    @Published var remainingSeconds: Int = 0
    let nameTeamA: String = "A"
    let nameTeamB: String = "B"
    let currentTurn: CurrentTurn = .teamA
    let currentTeamName: String = "A"
    let scoreTeamA: Int = 0
    let scoreTeamB: Int = 0
    let categories: [Category] = QuestionSet.example.questions.map(\.category).map({ Category(name: $0, state: .unanswered) })
    let gameStatus: GameStatus
    let correctAnswer: Answer? = nil
    @Published var selectedAnswer: Answer?
    @Published var selectedCategoryIndex: Int = -1
    @Published var finalAnswerTeamA: Answer?
    @Published var finalAnswerTeamB: Answer?
    let currentQuestion: Question? = QuestionSet.example.questions.first!

    init(gameStatus: GameStatus) {
        self.gameStatus = gameStatus
        self.startTimer()
    }

    private func decrease() { withAnimation { remainingSeconds -= 1 } }
    private func invalidate() { timer?.invalidate() }

    @MainActor
    private func startTimer() {
        self.remainingSeconds = 10
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            Task {
                if await self.remainingSeconds > 0 {
                    await self.decrease()
                } else {
                    await self.invalidate()
                }
            }
        })
    }

    var showNextButton: Bool {
        switch gameStatus {
        case .gameStarted, .gameEnded: false
        case .choosingCategory: selectedCategoryIndex > -1
        case .answeringQuestion: correctAnswer != nil
        case .finale: betTeamA > 0 && betTeamB > 0
        case .showingFinalQuestion: correctAnswer != nil
        }
    }

    var showAnswerButton: Bool {
        switch gameStatus {
        case .gameStarted, .gameEnded, .choosingCategory: false
        case .answeringQuestion: selectedAnswer != nil && correctAnswer == nil
        case .finale: false
        case .showingFinalQuestion: finalAnswerTeamA != nil && finalAnswerTeamB != nil && correctAnswer == nil
        }
    }

    func next() { }

    func answer() { }

    func endGame() { }
}
