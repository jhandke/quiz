//
//  GameInstanceDetailView.swift
//  Quiz
//
//  Created by Jakob Handke on 22.05.26.
//

import SwiftUI

struct GameInstanceDetailView: View {
    let gameInstance: GameInstance

    var body: some View {
        ScrollView {
            Text(gameInstance.questionSetName)
                .font(.title)
            Text(gameInstance.lastChange, style: .date)
            ScoreView(
                nameTeamA: gameInstance.nameTeamA,
                scoreTeamA: gameInstance.scoreTeamA,
                nameTeamB: gameInstance.nameTeamB,
                scoreTeamB: gameInstance.scoreTeamB,
                large: false
            )
            ForEach(gameInstance.givenAnswers) { givenAnswer in
                AnsweredQuestionCard(givenAnswer: givenAnswer, team: "team")
                    .padding(.horizontal)
            }
        }
    }
}

struct AnsweredQuestionCard: View {
    let givenAnswer: GivenAnswer
    let team: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(givenAnswer.question.text)
                .font(.headline)
            Text(givenAnswer.answer.text)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            if givenAnswer.question.correctAnswer == givenAnswer.answer {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.blue.opacity(0.9).gradient)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.blue.opacity(0.9).gradient)
            }
        }
    }
}

#Preview {
    GameInstanceDetailView(gameInstance: GameInstance.example)
}
