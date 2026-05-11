//
//  SetBetView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.05.26.
//

import SwiftUI

struct SetBetView: View {
    let scoreTeamA: Int
    let scoreTeamB: Int
    @Binding var betTeamA: Int
    @Binding var betTeamB: Int
    var showControls: Bool

    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top) {
                Text("Team A setzt \(betTeamA) von \(scoreTeamA) Punkten.")
                if showControls {
                    Stepper("", value: $betTeamA, in: 0...scoreTeamA, step: 10)
                }
            }
            HStack(alignment: .top) {
                Text("Team B setzt \(betTeamB) von \(scoreTeamB) Punkten.")
                if showControls {
                    Stepper("", value: $betTeamB, in: 0...scoreTeamB, step: 10)
                }
            }
        }
        .padding()
        .background(Color.orange.gradient, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    @Previewable @State var betTeamA: Int = 0
    @Previewable @State var betTeamB: Int = 0

    SetBetView(scoreTeamA: 400, scoreTeamB: 500, betTeamA: $betTeamA, betTeamB: $betTeamB, showControls: true)
}
