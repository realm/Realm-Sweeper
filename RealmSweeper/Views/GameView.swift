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
    
    @State private var remainingBombs = 0
    @State private var winningTime: Int?
    @State private var gameOver = false
    
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
                Text(latestMoveTime, style: .time)
            }
            if let winningTime = winningTime {
                Text("Game completed in \(winningTime) seconds")
            }
            Text("\(remainingBombs) bombs remaining")
            if let board = game.board {
                BoardView(board: board, gameOver: gameOver, newMove: newMove)
                    .padding()
            }
        }
        .onChange(of: game.latestMoveTime) { _ in
            countBombs()
        }
        .onAppear(perform: countBombs)
    }
    
//    private func gameOver(_ win: Bool) {
//    }
    
    private func countBombs() {
        if let board = game.board {
            remainingBombs = board.remainingBombs
        }
    }
    
    private func newMove() {
        let date = Date()
        if game.startTime == nil {
            $game.startTime.wrappedValue = date
        }
        $game.latestMoveTime.wrappedValue = date
        if game.hasWon {
            if let startTime = game.startTime {
                winningTime = Int(date.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate)
                print("WON!")
                gameOver = true
            }
        }
        if game.hasLost {
            gameOver = true
            print("LOST!")
        }
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
