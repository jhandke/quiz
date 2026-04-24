//
//  ExternalDisplayViewModel.swift
//  Quiz
//
//  Created by Jakob Handke on 06.03.26.
//

import Foundation

@Observable
final class ExternalDisplayViewModel {
    private var observers: [NSObjectProtocol] = []
    var gameViewModel: GameViewModel?
    var hidden: Bool = false

    init() {
        let gameStateChangedObserver = NotificationCenter.default.addObserver(forName: .gameStateChanged, object: nil, queue: .main) { [weak self] notification in
            guard let newGameViewModel = notification.userInfo?["gameViewModel"] as? GameViewModel else { return }
            self?.update(newGameViewModel: newGameViewModel)
        }
        self.observers.append(gameStateChangedObserver)

        let hideDisplayObserver = NotificationCenter.default.addObserver(forName: .hideExternalDisplay, object: nil, queue: .main) { [weak self] notification in
            self?.hidden = true
        }
        self.observers.append(hideDisplayObserver)

        let showDisplayObserver = NotificationCenter.default.addObserver(forName: .showExternalDisplay, object: nil, queue: .main) { [weak self] notification in
            self?.hidden = false
        }
        self.observers.append(showDisplayObserver)
    }

    deinit {
        observers.forEach { observer in
            NotificationCenter.default.removeObserver(observer)
        }
    }

    private func update(newGameViewModel: GameViewModel) {
        self.gameViewModel = newGameViewModel
        print(newGameViewModel)
        print("Selected: \(newGameViewModel.selectedAnswer?.text ?? "No answer selected")")
    }

    var currentQuestion: Question? {
        return gameViewModel?.currentQuestion
    }

    var selectedAnswer: Answer? {
        return gameViewModel?.selectedAnswer
    }

    var correctAnswer: Answer? {
        return gameViewModel?.correctAnswer
    }
}
