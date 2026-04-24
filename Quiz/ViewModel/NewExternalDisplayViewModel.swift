//
//  NewExternalDisplayViewModel.swift
//  Quiz
//
//  Created by Jakob Handke on 21.04.26.
//

import Foundation
import Observation

@Observable
final class NewExternalDisplayViewModel {
    private var game: Game?

    @MainActor init() {
        withObservationTracking {
            // Only read the observed value inside the tracking closure
            _ = QuizState.shared.game
        } onChange: { [weak self] in
            // Hop to the MainActor to safely access actor-isolated properties
            Task { @MainActor [weak self] in
                guard let self else { return }
                let newGame: Game?
                switch QuizState.shared.game {
                case .noGame:
                    newGame = nil
                case .gameRunning(let game):
                    newGame = game
                }
                self.game = newGame
            }
        }

        // Also perform an initial assignment on init
        let initialGame: Game?
        switch QuizState.shared.game {
        case .noGame:
            initialGame = nil
        case .gameRunning(let game):
            initialGame = game
        }
        self.game = initialGame
    }

    var gameAvailable: Bool {
        game != nil
    }

    var currentQuestion: Question? {
        game?.currentQuestion
    }

    var selectedAnswer: Answer? {
        return game?.selectedAnswer
    }

    var correctAnswer: Answer? {
        currentQuestion?.correctAnswer
    }
}
