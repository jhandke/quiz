struct GameInstanceDetailView: View {
    let gameInstance: GameInstance

    var body: some View {
        HStack {
            Text(gameInstance.questionSetName)
            ScoreView(
                nameTeamA: gameInstance.nameTeamA,
                scoreTeamA: gameInstance.scoreTeamA,
                nameTeamB: gameInstance.nameTeamB,
                scoreTeamB: gameInstance.scoreTeamB,
                large: false
            )
        }

    }
}