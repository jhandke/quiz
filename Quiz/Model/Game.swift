//
//  Game.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData

@Observable
final class Game {
//    private var gameInstance: GameInstance
    private let questions: [Question]
    private var currentQuestionIndex = 0
    private var selectedAnswerIndex = -1

//    private var modelContext: ModelContext
//    private var modelContainer: ModelContainer

    init(questionSet: QuestionSet, playerA: String, playerB: String) {
//        self.gameInstance = GameInstance(from: questionSet, playerA: playerA, playerB: playerB)
        self.questions = questionSet.questions

//        let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
//        guard let container = try? ModelContainer(for: GameInstance.self, configurations: configuration) else {
//            fatalError("Unable to create ModelContainer for GameInstance.")
//        }
//        self.modelContainer = container
//        self.modelContext = container.mainContext
//        self.modelContext.autosaveEnabled = true

//        self.modelContext.insert(self.gameInstance)
    }

    var finished: Bool {
        false
//        gameInstance.finished
    }

    var currentQuestion: Question? {
        return questions[safeIndex: currentQuestionIndex]
    }

    var selectedAnswer: Answer? {
        if selectedAnswerIndex < 0 {
            return nil
        }
        return currentQuestion?.answers[safeIndex: selectedAnswerIndex]
    }

    func advanceGameState(answer: Answer) -> Bool {
        if questions.count <= currentQuestionIndex + 1 {
            print(#function, "End of game reached.")
            return false
        }
        guard let currentQuestion else {
            print("No current question available. This is bad.")
            return false
        }
        currentQuestionIndex += 1
//        gameInstance.unansweredQuestions.removeAll(where: { $0 == currentQuestion })
//        gameInstance.answeredQuestions[currentQuestion] = answer
//        try? self.modelContext.save()
        self.selectedAnswerIndex = -1
        return true
    }

    func selectQuestion(index: Int) {
        assert(index < questions.count, "Index out of range.")
        self.selectedAnswerIndex = index
    }
}
