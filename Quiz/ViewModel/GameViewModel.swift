//
//  GameViewModel.swift
//  Quiz
//
//  Created by Jakob Handke on 06.03.26.
//

import Foundation

@Observable
class GameViewModel {
    private let game: Game

    var showResultButton = false
    var correctAnswer: Answer? = nil
    var selectedAnswer: Answer? {
        didSet {
            showResultButton = selectedAnswer != nil
            NotificationCenter.default.post(name: .gameStateChanged, object: nil, userInfo: ["gameViewModel": self])
        }
    }

    init(questionSet: QuestionSet) {
        print("init fired")
        self.game = Game(questionSet: questionSet, playerA: "Player A", playerB: "Player B")

//        NotificationCenter.default.post(name: .gameStateChanged, object: nil, userInfo: ["gameViewModel": self])
    }

    func start() {
        NotificationCenter.default.post(name: .gameStateChanged, object: nil, userInfo: ["gameViewModel": self])
    }

    var currentQuestion: Question? {
        game.currentQuestion
    }

    func advanceGameState() {
//        if game.advanceGameState() {
//            selectedAnswer = nil
//            correctAnswer = nil
//            showResultButton = false
//        }
//        NotificationCenter.default.post(name: .gameStateChanged, object: nil, userInfo: ["gameViewModel": self])
    }

    func checkAnswer() {
        guard let selectedAnswer else {
            print(#file, #function, "No answer selected.")
            return
        }

        correctAnswer = game.currentQuestion?.correctAnswer
//        game.setAnswer(correct: selectedAnswer.isCorrect)
//        game.advanceGameState(answer: <#T##Answer#>)
//        NotificationCenter.default.post(name: .gameStateChanged, object: nil, userInfo: ["gameViewModel": self])
    }

    func endGame() {
        print(#function, "To be imlemented...")
    }
}
