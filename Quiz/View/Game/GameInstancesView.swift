//
//  GameInstancesView.swift
//  Quiz
//
//  Created by Jakob Handke on 27.04.26.
//

import SwiftUI
import SwiftData

struct GameInstancesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var finishedGameInstances: [GameInstance]
    @Query var unfinishedGameInstances: [GameInstance]

    init() {
        let finishedPredicate = #Predicate<GameInstance> {
            $0.givenAnswers.count == $0.questions.count &&
            $0.finalAnswerTeamA != nil && $0.finalAnswerTeamB != nil
        }
        let notAllQuestionsAnswered = #Predicate<GameInstance> {
            $0.givenAnswers.count < $0.questions.count
        }
        let finalAnswersNil = #Predicate<GameInstance> {
            $0.finalAnswerTeamA == nil || $0.finalAnswerTeamB == nil
        }
        let unfinishedPredicate = #Predicate<GameInstance> {
            notAllQuestionsAnswered.evaluate($0) && finalAnswersNil.evaluate($0)
        }
        self._finishedGameInstances = Query(filter: finishedPredicate)
        self._unfinishedGameInstances = Query(filter: unfinishedPredicate)
    }

    var body: some View {
        if unfinishedGameInstances.isEmpty && finishedGameInstances.isEmpty {
            ContentUnavailableView("Du hast noch keine Runde gespielt.", systemImage: "tray")
                .navigationTitle("Gespielte Runden")
        } else {
            List {
                if !unfinishedGameInstances.isEmpty {
                    Section("Offene Spiele") {
                        ForEach(unfinishedGameInstances) { gameInstance in
                            NavigationLink(value: gameInstance) {
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
                        }
                        .onDelete { offsets in
                            withAnimation {
                                modelContext.delete(unfinishedGameInstances[offsets.first!])
                            }
                        }
                    }
                    if !finishedGameInstances.isEmpty {
                        Section("Abgeschlossene Spiele") {
                            ForEach(finishedGameInstances) { gameInstance in
                                NavigationLink(value: gameInstance) {
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
                            }
                            .onDelete { offsets in
                                withAnimation {
                                    modelContext.delete(finishedGameInstances[offsets.first!])
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Gespielte Runden")
            .navigationDestination(for: GameInstance.self) { gameInstance in
                GameInstanceDetailView(gameInstance: gameInstance)
            }
        }
    }
}

#Preview {
    let container = ModelContainerProvider.preview
    container.mainContext.insert(GameInstance.example)

    return NavigationStack {
        GameInstancesView()
            .modelContainer(container)
    }
}
