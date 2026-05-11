//
//  GameViewModel.swift
//  Quiz
//
//  Created by Jakob Handke on 06.03.26.
//

import Foundation
import Combine
import SwiftUI

protocol GameViewModelProtocol: ObservableObject {
    var remainingSeconds: Int { get }
    var nameTeamA: String { get }
    var nameTeamB: String { get }
    var currentTurn: CurrentTurn { get }
    var currentTeamName: String { get }
    var scoreTeamA: Int { get }
    var scoreTeamB: Int { get }
    var categories: [Category] { get }
    var gameStatus: GameStatus { get }
    var correctAnswer: Answer? { get }
    var selectedAnswer: Answer? { get set }
    var selectedCategoryIndex: Int { get set }
    var betTeamA: Int { get set }
    var betTeamB: Int { get set }
    var finalAnswerTeamA: Answer? { get set }
    var finalAnswerTeamB: Answer? { get set }
    var showNextButton: Bool { get }
    var showAnswerButton: Bool { get }
    var currentQuestion: Question? { get }
    func next()
    func answer()
    func endGame()
}

class GameViewModel: GameViewModelProtocol, ObservableObject {
    private let gameInstance: GameInstance

    private var lastQuestionTimer: Timer?
    @Published var remainingSeconds: Int = 0

    private func decreaseTimer() { print("decrease: \(remainingSeconds)"); withAnimation { remainingSeconds -= 1 } }
    private func invalidateTimer() { print("invalidate"); lastQuestionTimer?.invalidate(); remainingSeconds = 0 }

    let nameTeamA: String
    let nameTeamB: String

    var currentTurn: CurrentTurn {
        gameInstance.currentTurn
    }

    var currentTeamName: String {
        switch currentTurn {
        case .teamA:
            return nameTeamA
        case .teamB:
            return nameTeamB
        }
    }

    var scoreTeamA: Int {
        gameInstance.scoreTeamA
    }

    var scoreTeamB: Int {
        gameInstance.scoreTeamB
    }

    private(set) var categories: [Category]
    @Published private(set) var gameStatus = GameStatus.gameStarted

    @Published private(set) var correctAnswer: Answer?
    @Published var selectedAnswer: Answer?
    @Published var selectedCategoryIndex: Int = -1

    @Published var betTeamA: Int = 0
    @Published var betTeamB: Int = 0

    @Published var finalAnswerTeamA: Answer? { didSet { self.objectWillChange.send() } }
    @Published var finalAnswerTeamB: Answer? { didSet { self.objectWillChange.send() } }

    init(questionSet: QuestionSet, nameTeamA: String, nameTeamB: String) {
        self.gameInstance = GamePersistenceService.shared.create(from: questionSet, nameTeamA: nameTeamA, nameTeamB: nameTeamB)

        self.categories = questionSet.questions.map({ question in
            return Category(name: question.category, state: .unanswered)
        })
        self.nameTeamA = nameTeamA
        self.nameTeamB = nameTeamB

        self.gameStatus = .choosingCategory(categories: self.categories)
        QuizState.shared.game = .gameRunning(viewModel: self)
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

    func next() {
        switch gameStatus {
        case .gameStarted:
            self.gameStatus = .choosingCategory(categories: self.categories)
        case .choosingCategory:
            self.selectCategory(index: selectedCategoryIndex)
            if let selectedQuestion = gameInstance.selectedQuestion {
                self.gameStatus = .answeringQuestion(question: selectedQuestion)
            } else {
                print(#file, #function, "Unable to find question for selected category. This is very bad!")
            }
            self.selectedCategoryIndex = -1
        case .answeringQuestion:
            if gameInstance.givenAnswers.count >= gameInstance.questions.count {
                self.gameStatus = .finale(category: Category(name: gameInstance.finalQuestion.category, state: .unanswered))
            } else {
                self.gameStatus = .choosingCategory(categories: self.categories)
            }
            self.selectedAnswer = nil
            self.correctAnswer = nil
        case .finale:
            gameInstance.betOnFinalQuestion(team: .teamA, amount: betTeamA)
            self.betTeamA = gameInstance.finalBetTeamA
            gameInstance.betOnFinalQuestion(team: .teamB, amount: betTeamB)
            self.betTeamB = gameInstance.finalBetTeamB
            self.gameStatus = .showingFinalQuestion(question: gameInstance.finalQuestion)
            self.startTimer(seconds: 30)
        case .showingFinalQuestion:
            self.gameStatus = .gameEnded
            self.invalidateTimer()
        case .gameEnded:
            break
        }
    }

    func answer() {
        switch gameStatus {
        case .gameStarted, .choosingCategory, .finale, .gameEnded:
            break
        case .answeringQuestion:
            answerQuestion()
        case .showingFinalQuestion:
            guard let finalAnswerTeamA, let finalAnswerTeamB else { return }
            gameInstance.answerFinalQuestion(answerTeamA: finalAnswerTeamA, answerTeamB: finalAnswerTeamB)
            self.correctAnswer = self.gameInstance.finalQuestion.correctAnswer
            self.invalidateTimer()
        }
    }

    var currentQuestion: Question? {
        gameInstance.selectedQuestion
    }

    private func selectCategory(index: Int) {
        self.categories[index].state = .answered
        gameInstance.selectQuestionForCategory(categories[selectedCategoryIndex].name)
    }

    private func answerQuestion() {
        guard let currentQuestion, let selectedAnswer else {
            print(#function, #file, "No question or answer available.")
            return
        }
        gameInstance.answerQuestion(currentQuestion, with: selectedAnswer)
        self.correctAnswer = currentQuestion.correctAnswer
    }

    func endGame() {
        QuizState.shared.game = .noGame
        print(#function, "To be imlemented...")
    }

    @MainActor
    private func startTimer(seconds: Int) {
        self.remainingSeconds = seconds
        self.lastQuestionTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            Task {
                if await self.remainingSeconds > 0 {
                    await self.decreaseTimer()
                } else {
                    await self.invalidateTimer()
                }
            }
        })
    }
}
