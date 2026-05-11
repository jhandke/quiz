//
//  PrepareGameView.swift
//  Quiz
//
//  Created by Jakob Handke on 26.04.26.
//

import SwiftUI

struct PrepareGameView: View {
    let questionSet: QuestionSet
    @State private var nameTeamA: String = ""
    @State private var nameTeamB: String = ""
    @EnvironmentObject private var navigation: NavigationState

    var body: some View {
        Form {
            Section {
                Text("Der Fragensatz \"\(questionSet.name)\" wird gespielt.")
            }
            Text("Gib die Namen der beiden Teams ein:")
            TextField("Team A", text: $nameTeamA)
            TextField("Team B", text: $nameTeamB)

            Section {
                NavigationLink("Starten", value: GameNavigation.playing)
                    .disabled(nameTeamA.isEmpty || nameTeamB.isEmpty)
            }
        }
        .navigationDestination(for: GameNavigation.self) { navigation in
            switch navigation {
            case .playing:
                GameView(viewModel: GameViewModel(questionSet: questionSet, nameTeamA: nameTeamA, nameTeamB: nameTeamB),
                                large: false)
                    .navigationBarBackButtonHidden()
                    .environmentObject(self.navigation)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PrepareGameView(questionSet: QuestionSet.example)
    }
}
