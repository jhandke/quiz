//
//  GameInstanceCellView.swift
//  Quiz
//
//  Created by Jakob Handke on 28.04.26.
//

import SwiftUI

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
    List {
        GameInstanceCellView(
            name: "Fragensatz eins",
            lastEdit: .distantPast,
            answeredQuestions: 8,
            totalQuestions: 12,
            nameTeamA: "Peter und Jan",
            scoreTeamA: 200,
            nameTeamB: "Olaf und Kerstin",
            scoreTeamB: 400
        )
    }
}
