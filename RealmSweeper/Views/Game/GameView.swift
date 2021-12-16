//
//  GameView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import SwiftUI
import RealmSwift

struct GameView: View {
    @ObservedRealmObject var game: Game
    
    @State private var remainingMines = 0
    
    var body: some View {
        VStack {
            if let startTime = game.startTime {
                HStack {
                    Text("Start time: ")
                    TextDate(startTime)
                }
            }
            if let latestMoveTime = game.latestMoveTime {
                HStack {
                    Text("Most recent move: ")
                    TextDate(latestMoveTime)
                }
            }
            if let winningTime = game.winningTimeInSeconds {
                Text("Game completed in \(winningTime) seconds")
            }
            Text("\(remainingMines) mines remaining")
            if let board = game.board {
                BoardView(board: board, gameStatus: $game.gameStatus, newMove: newMove)
                    .padding()
            }
        }
        .onChange(of: game.latestMoveTime) { _ in
            countMines()
        }
        .onAppear(perform: countMines)
    }
    
    private func countMines() {
        if let board = game.board {
            remainingMines = board.remainingMines
        }
    }
    
    private func newMove() {
        let date = Date()
        if game.startTime == nil {
            $game.startTime.wrappedValue = date
            $game.gameStatus.wrappedValue = .inProgress
        }
        $game.latestMoveTime.wrappedValue = date
        if game.hasWon {
            if let startTime = game.startTime {
                $game.winningTimeInSeconds.wrappedValue = Int(date.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate)
                $game.gameStatus.wrappedValue = .won
            }
        }
        if game.hasLost {
            $game.gameStatus.wrappedValue = .lost
        }
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
