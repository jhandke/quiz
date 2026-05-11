//
//  GameStatus.swift
//  Quiz
//
//  Created by Jakob Handke on 26.04.26.
//

import Foundation

enum GameStatus {
    case gameStarted
    case choosingCategory(categories: [Category])
    case answeringQuestion(question: Question)
    case finale(category: Category)
    case showingFinalQuestion(question: Question)
    case gameEnded
}
