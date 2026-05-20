//
//  GameInstancesView.swift
//  Quiz
//
//  Created by Jakob Handke on 27.04.26.
//

import SwiftUI
import SwiftData

struct GameInstancesView: View {
    var unfinishedGameInstances: [GameInstance] = GamePersistenceService.shared.getUnfinished() ?? []
    var finishedGameInstances: [GameInstance] = GamePersistenceService.shared.getFinished() ?? []

    var body: some View {
        if unfinishedGameInstances.isEmpty && finishedGameInstances.isEmpty {
            ContentUnavailableView("Du hast noch keine Runde gespielt.", systemImage: "tray")
                .navigationTitle("Gespielte Runden")
        } else {
            List {
                if !unfinishedGameInstances.isEmpty {
                    Section("Offene Spiele") {
                        ForEach(unfinishedGameInstances) { gameInstance in
                            GameInstanceCellView(
                                name: gameInstance.questionSetName,
                                lastEdit: gameInstance.lastChange,
                                answeredQuestions: gameInstance.givenAnswers.count,
                                totalQuestions: gameInstance.questions.count,
                                nameTeamA: gameInstance.nameTeamA,
                                scoreTeamA: gameInstance.scoreTeamA,
                                nameTeamB: gameInstance.nameTeamB,
                                scoreTeamB: gameInstance.scoreTeamB
                            )
                        }
                        .onDelete { offsets in
                            withAnimation {
                                GamePersistenceService.shared.delete(unfinishedGameInstances[offsets.first!])
                            }
                        }
                    }
                }
                if !finishedGameInstances.isEmpty {
                    Section("Abgeschlossene Spiele") {
                        ForEach(finishedGameInstances) { gameInstance in
                            GameInstanceCellView(
                                name: gameInstance.questionSetName,
                                lastEdit: gameInstance.lastChange,
                                answeredQuestions: gameInstance.givenAnswers.count,
                                totalQuestions: gameInstance.questions.count,
                                nameTeamA: gameInstance.nameTeamA,
                                scoreTeamA: gameInstance.scoreTeamA,
                                nameTeamB: gameInstance.nameTeamB,
                                scoreTeamB: gameInstance.scoreTeamB
                            )
                        }
                        .onDelete { offsets in
                            withAnimation {
                                GamePersistenceService.shared.delete(finishedGameInstances[offsets.first!])
                            }
                        }
                    }
                }
            }
            .navigationTitle("Gespielte Runden")
        }
    }
}

#Preview {
    let container = ModelContainerProvider.preview
    container.mainContext.insert(
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

    return NavigationStack {
        GameInstancesView()
            .modelContainer(container)
    }
}
