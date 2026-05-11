//
//  StartView.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI
import SwiftData
import Combine

struct StartView: View {
    @StateObject var navigation = NavigationState()
    @State private var hideTabBar = false

    var body: some View {
        TabView {
            NavigationStack(path: $navigation.path) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quiz")
                            .font(.largeTitle)
                        StartViewCell(title: "Spiel starten",
                                      description: "Wähle einen Fragensatz aus und starte die Quizrunde",
                                      systemImage: "gamecontroller.circle",
                                      action: {
                            withAnimation {
                                hideTabBar = true
                            }
                            navigation.path.append(RootDestination.game) })
                        .buttonStyle(.borderedProminent)
                        StartViewCell(title: "Gespielte Runden",
                                      description: "Sieh dir die Ergebnisse deiner bisherigen Spiele an",
                                      systemImage: "list.bullet.circle",
                                      action: { navigation.path.append(RootDestination.rounds) })
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                .navigationDestination(for: RootDestination.self) { destination in
                    switch destination {
                    case .game:
                        SelectGameView()
                            .environmentObject(navigation)
                    case .rounds:
                        GameInstancesView()
                    case .editQuestionSets:
                        EditQuestionSetsView()
                    }
                }
            }
            .tabItem { Label("Spielen", systemImage: "gamecontroller") }

            EditQuestionSetsView()
                .ignoresSafeArea(edges: .all)
                .tabItem { Label("Fragen bearbeiten", systemImage: "pencil") }
        }
//        NavigationStack(path: $navigation.path) {
//            ScrollView {
//                VStack(spacing: 16) {
//
//                    StartViewCell(title: "Fragen bearbeiten",
//                                  description: "Erstelle und korrigiere Fragen und Kategorien",
//                                  systemImage: "pencil.circle",
//                                  action: { navigation.path.append(RootDestination.editQuestionSets) })
//                }
//                .padding()
//                .buttonStyle(.bordered)
//                .navigationTitle("Quiz")

//            }
//        }
    }
}

struct StartViewCell: View {
    let title: String
    let description: String
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            HStack {
                Image(systemName: systemImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 50, alignment: .leading)
                VStack(alignment: .leading) {
                    Text(title)
                    Text(description)
                        .font(.caption)
                        .multilineTextAlignment(.leading)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .frame(maxWidth: .infinity)
        })
        .controlSize(.large)
    }
}

enum RootDestination {
    case game
    case rounds
    case editQuestionSets
}

#Preview {
    // swiftlint:disable force_try
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionSet.self, configurations: config)
    container.mainContext.insert(QuestionSet.example)

    return StartView()
        .modelContainer(container)
    // swiftlint:enable force_try
}
