//
//  StartView.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import SwiftUI
import SwiftData

struct StartView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SelectGameView()) {
                    Text("Spielen")
                }
                .padding(.bottom)
                NavigationLink(destination: EditQuestionSetsView()) {
                    Text("Fragen bearbeiten")
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionSet.self, configurations: config)
    container.mainContext.insert(QuestionSet.example)

    return StartView()
        .modelContainer(container)
}
