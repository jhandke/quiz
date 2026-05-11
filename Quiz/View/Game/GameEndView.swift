//
//  GameEndView.swift
//  Quiz
//
//  Created by Jakob Handke on 27.04.26.
//

import SwiftUI

struct GameEndView: View {
    let nameTeamA: String
    let scoreTeamA: Int
    let nameTeamB: String
    let scoreTeamB: Int
    let large: Bool

    var body: some View {
        VStack {
            Text("Fertig wuhu")
                .font(large ? .externalLargeTitle : .title)
                .padding()
            switch (scoreTeamA, scoreTeamB) {
            case (let scoreTeamA, let scoreTeamB) where scoreTeamA > scoreTeamB:
                Text("Team \(nameTeamA) gewinnt mit \(scoreTeamA) Punkten! 🎉")
                    .font(large ? .externalTitle : .title3)
            case (let scoreTeamA, let scoreTeamB) where scoreTeamA < scoreTeamB:
                Text("Team \(nameTeamB) gewinnt mit \(scoreTeamB) Punkten! 🎉")
                    .font(large ? .externalTitle : .title3)
            default:
                Text("Unentschieden!")
                    .font(large ? .externalTitle : .title3)
            }
        }
    }
}

#Preview {
    GameEndView(nameTeamA: "Bernard und Paul", scoreTeamA: 2500, nameTeamB: "Elton und Micaela", scoreTeamB: 2400, large: false)
}
