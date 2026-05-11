//
//  FinaleView.swift
//  Quiz
//
//  Created by Jakob Handke on 09.05.26.
//

import SwiftUI

struct FinaleView: View {
    let category: Category
    let scoreTeamA: Int
    let scoreTeamB: Int
    let nameTeamA: String
    let nameTeamB: String
    @Binding var betTeamA: Int
    @Binding var betTeamB: Int
    let large: Bool

    var body: some View {
        VStack(spacing: 20) {
            CategoryCell(category: category, selected: false, large: large, square: false)
            SetBetView(scoreTeamA: scoreTeamA, scoreTeamB: scoreTeamB, betTeamA: $betTeamA, betTeamB: $betTeamB, showControls: !large)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var betTeamA: Int = 120
    @Previewable @State var betTeamB: Int = 150

    FinaleView(category: Category(name: "Olympische Spiele", state: .unanswered),
               scoreTeamA: 200,
               scoreTeamB: 300,
               nameTeamA: "A",
               nameTeamB: "B",
               betTeamA: $betTeamA,
               betTeamB: $betTeamB,
               large: false)
}
