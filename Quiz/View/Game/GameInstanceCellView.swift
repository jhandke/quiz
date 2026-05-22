//
//  GameInstanceCellView.swift
//  Quiz
//
//  Created by Jakob Handke on 28.04.26.
//

import SwiftUI
import SwiftData

struct GameInstanceCellView: View {
    let name: String
    let lastEdit: Date
    let answeredQuestions: Int
    let totalQuestions: Int
    let nameTeamA: String
    let scoreTeamA: Int
    let nameTeamB: String
    let scoreTeamB: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text(name)
                    .font(.title2)
                Spacer()
                Text("Runde \(answeredQuestions) von \(totalQuestions)")
            }
            Text("\(lastEdit.formatted(date: .abbreviated, time: .shortened)) Uhr")
                .font(.caption)

            ScoreView(nameTeamA: nameTeamA, scoreTeamA: scoreTeamA, nameTeamB: nameTeamB, scoreTeamB: scoreTeamB, large: false)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    let gameInstance = GameInstance.example
    List {
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
