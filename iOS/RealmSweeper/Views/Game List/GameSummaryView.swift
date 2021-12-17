//
//  GameSummaryView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 17/12/2021.
//

import SwiftUI

struct GameSummaryView: View {
    let game: Game
    var body: some View {
        VStack {
            HStack {
                if let startTime = game.startTime {
                    Text("Start time: ")
                    TextDate(startTime)
                    Spacer()
                    Text(game.statusEmoji)
                }
            }
            HStack {
                if let completionTime = game.winningTimeInSeconds {
                    Text("Completed in \(completionTime) seconds")
                }
                Spacer()
                if let board = game.board {
                    Text("\(game.numRows)x\(game.numCols) - \(board.startingNumberOfMines) mine\(board.startingNumberOfMines == 1 ? "" : "s")")
                        .font(.caption)
                }
            }
        }
    }
}

struct GameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game()
        game.startTime = Date()
        game.winningTimeInSeconds = 123
        return _PreviewColorScheme (
            GameSummaryView(game: game)
                .padding()
        )
    }
}
