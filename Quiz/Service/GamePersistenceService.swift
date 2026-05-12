//
//  GamePersistenceService.swift
//  Quiz
//
//  Created by Jakob Handke on 27.04.26.
//

import Foundation
import SwiftData

final class GamePersistenceService {
    static let shared = GamePersistenceService()

    private var modelContext: ModelContext
    private var modelContainer: ModelContainer

    init(inMemory: Bool = false) {
        let config = ModelConfiguration(for: GameInstance.self, QuestionSet.self, Question.self, Answer.self, GivenAnswer.self,
                                        isStoredInMemoryOnly: inMemory)
        guard let container = try? ModelContainer(
            for: GameInstance.self, QuestionSet.self, Question.self, Answer.self, GivenAnswer.self,
            configurations: config
        ) else {
            fatalError("Unable to create ModelContainer.")
        }
        self.modelContainer = container
        self.modelContext = ModelContext(self.modelContainer)
        self.modelContext.autosaveEnabled = true
    }

    func getAll() -> [GameInstance]? {
        let descriptor = FetchDescriptor<GameInstance>(sortBy: [.init(\.lastChange, order: .reverse)])
        do {
            let allInstances = try modelContext.fetch(descriptor)
            return allInstances
        } catch {
            print(#file, #function, error.localizedDescription)
            return nil
        }
    }

    func getUnfinished() -> [GameInstance]? {
        guard let allInstances = self.getAll() else {
            return nil
        }
        return allInstances.filter { gameInstance in
            gameInstance.givenAnswers.count < gameInstance.questions.count
        }
    }

    func getFinished() -> [GameInstance]? {
        guard let allInstances = self.getAll() else {
            return nil
        }
        return allInstances.filter { gameInstance in
            gameInstance.givenAnswers.count >= gameInstance.questions.count
        }
    }

    func create(from questionSet: QuestionSet, nameTeamA: String, nameTeamB: String) -> GameInstance {
        let questions = questionSet.questions.map({ $0.clone() })
        print("Found \(questions.count) questions.")

        let gameInstance = GameInstance(
            questions: questions,
            questionSetName: questionSet.name,
            nameTeamA: nameTeamA,
            nameTeamB: nameTeamB,
            scoreTeamA: 0,
            scoreTeamB: 0,
            currentTurnRaw: "teamA",
            selectedQuestion: nil,
            givenAnswers: [],
            finalBetTeamA: 0,
            finalBetTeamB: 0,
            finalAnswerTeamA: nil,
            finalAnswerTeamB: nil,
            finalQuestion: questionSet.finalQuestion.clone(),
            lastChange: .now
        )
        modelContext.insert(gameInstance)
        do {
            try modelContext.save()
        } catch {
            print(#file, #function, error.localizedDescription)
        }
        return gameInstance
    }

    func delete(_ gameInstance: GameInstance) {
        modelContext.delete(gameInstance)
        do {
            try modelContext.save()
        } catch {
            print(#file, #function, error.localizedDescription)
        }
    }
}
