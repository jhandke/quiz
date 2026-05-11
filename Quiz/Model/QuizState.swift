//
//  QuizState.swift
//  Quiz
//
//  Created by Jakob Handke on 26.03.26.
//

import Foundation

enum GameState {
    case noGame
    case gameRunning(viewModel: GameViewModel)
}

@Observable
class QuizState {
    static let shared = QuizState()

    private init() { }

    var game: GameState = .noGame
}
