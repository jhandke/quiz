//
//  GameInstace.swift
//  Quiz
//
//  Created by Jakob Handke on 25.03.26.
//

import Foundation
import SwiftData

@Model
class GameInstance {
    private(set) var questions: [Question]
    private(set) var questionSetName: String
    private(set) var nameTeamA: String
    private(set) var nameTeamB: String
    private(set) var scoreTeamA: Int
    private(set) var scoreTeamB: Int
    private var currentTurnRaw: String
    private(set) var currentTurn: CurrentTurn {
        get { CurrentTurn(rawValue: currentTurnRaw) ?? .teamA }
        set { currentTurnRaw = newValue.rawValue }
    }
    var selectedQuestion: Question?
    private(set) var givenAnswers: [GivenAnswer]
    private(set) var finalBetTeamA: Int
    private(set) var finalBetTeamB: Int
    private(set) var finalQuestion: Question
    private(set) var finalAnswerTeamA: Answer?
    private(set) var finalAnswerTeamB: Answer?
    private(set) var lastChange: Date

    init(
        questions: [Question],
        questionSetName: String,
        nameTeamA: String,
        nameTeamB: String,
        scoreTeamA: Int,
        scoreTeamB: Int,
        currentTurnRaw: String,
        selectedQuestion: Question?,
        givenAnswers: [GivenAnswer],
        finalBetTeamA: Int,
        finalBetTeamB: Int,
        finalAnswerTeamA: Answer?,
        finalAnswerTeamB: Answer?,
        finalQuestion: Question,
        lastChange: Date = .now
    ) {
        self.questions = questions
        self.questionSetName = questionSetName
        self.nameTeamA = nameTeamA
        self.nameTeamB = nameTeamB
        self.scoreTeamA = scoreTeamA
        self.scoreTeamB = scoreTeamB
        self.currentTurnRaw = currentTurnRaw
        self.selectedQuestion = selectedQuestion
        self.givenAnswers = givenAnswers
        self.finalBetTeamA = finalBetTeamA
        self.finalBetTeamB = finalBetTeamB
        self.finalAnswerTeamA = finalAnswerTeamA
        self.finalAnswerTeamB = finalAnswerTeamB
        self.finalQuestion = finalQuestion
        self.lastChange = lastChange
    }

    @MainActor func selectQuestionForCategory(_ category: String) {
        guard let question = questions.first(where: { $0.category == category }) else {
            fatalError("Unable to find question with category \"\(category)\". This is bad!")
        }
        self.selectedQuestion = question
    }

    @MainActor func answerQuestion(_ question: Question, with answer: Answer) {
        guard !givenAnswers.contains(where: { givenAnswer in
            givenAnswer.question == question
        }) else {
            //        guard !(givenAnswers.keys.contains(question)) else {
            print(#file, #function, "The question \(question.text) has already been answered.")
            return
        }
        givenAnswers.append(GivenAnswer(question: question, answer: answer))
        if answer == question.correctAnswer {
            switch self.currentTurn {
            case .teamA:
                self.scoreTeamA += GameSettings.pointsForCorrectAnswer
            case .teamB:
                self.scoreTeamB += GameSettings.pointsForCorrectAnswer
            }
        }
        switch self.currentTurn {
        case .teamA:
            self.currentTurn = .teamB
        case .teamB:
            self.currentTurn = .teamA
        }
    }

    @MainActor func answerFinalQuestion(answerTeamA: Answer, answerTeamB: Answer) {
        if self.finalQuestion.correctAnswerUUID == answerTeamA.uuid {
            self.scoreTeamA += 2 * finalBetTeamA
        }

        if self.finalQuestion.correctAnswerUUID == answerTeamB.uuid {
            self.scoreTeamB += 2 * finalBetTeamB
        }
    }

    func betOnFinalQuestion(team: CurrentTurn, amount: Int) {
        switch team {
        case .teamA:
            guard self.scoreTeamA >= amount else {
                self.finalBetTeamA = self.scoreTeamA
                self.scoreTeamA = 0
                return
            }
            self.finalBetTeamA = amount
            self.scoreTeamA -= amount
        case .teamB:
            guard self.scoreTeamA >= amount else {
                self.finalBetTeamB = self.scoreTeamB
                self.scoreTeamB = 0
                return
            }
            self.finalBetTeamB = amount
            self.scoreTeamB -= amount
        }
    }
}

class GameInstancePreview {
    @MainActor
    static var data: ModelContainer {
        // swiftlint:disable force_try
        let container = try! ModelContainer(for: GameInstance.self,
                                            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        // swiftlint:enable force_try
        container.mainContext
            .insert(
                GameInstance(
                    questions: QuestionSet.example.questions,
                    questionSetName: QuestionSet.example.name,
                    nameTeamA: "A",
                    nameTeamB: "B",
                    scoreTeamA: 0,
                    scoreTeamB: 0,
                    currentTurnRaw: "teamA",
                    selectedQuestion: nil,
                    givenAnswers: [],
                    finalBetTeamA: 0,
                    finalBetTeamB: 0,
                    finalAnswerTeamA: nil,
                    finalAnswerTeamB: nil,
                    finalQuestion: QuestionSet.example.finalQuestion
                )
            )
        return container
    }
}
