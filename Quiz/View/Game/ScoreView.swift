//
//  ScoreView.swift
//  Quiz
//
//  Created by Jakob Handke on 26.04.26.
//

import SwiftUI

struct ScoreView: View {
    let nameTeamA: String
    let scoreTeamA: Int
    let nameTeamB: String
    let scoreTeamB: Int
    let large: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Punktestand")
                .font(large ? .externalBody : .title2)
            HStack {
                VStack(alignment: .leading) {
                    Text("Team \(nameTeamA):")
                    Text("Team \(nameTeamB):")
                }
                .fontWeight(.light)
                VStack(alignment: .trailing) {
                    Text("\(scoreTeamA)")
                    Text("\(scoreTeamB)")
                }
            }
            .font(large ? .externalBody : .default)
        }
        .padding()
        .background(Color.mint.gradient, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ScoreView(nameTeamA: "A", scoreTeamA: 200, nameTeamB: "Bablabla", scoreTeamB: 5000, large: false)
}
