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
    @Environment(\.presentationMode) var presentationMode
    
    @State private var remainingMines = 0
    @State private var elapsedTime = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                LEDCounter(count: remainingMines)
                    .frame(width: 150, height: 70)
                StatusButton(status: game.statusEmoji, action: newGame)
                    .frame(width: 70, height: 70)
                    .padding()
                LEDCounter(count: game.winningTimeInSeconds ?? (game.gameStatus == .inProgress ? elapsedTime : 888))
                    .frame(width: 150, height: 70)
                    .onReceive(timer, perform: updateElapsedTime)
                Spacer()
            }
            Spacer()
            if let board = game.board {
                VStack {
                    HStack {
                        BoardView(board: board, gameStatus: $game.gameStatus, newMove: newMove)
                            .padding()
                    }
                }
            }
            Spacer()
        }
        .background(.gray)
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
    
    private func updateElapsedTime(_ date: Date) {
        if let startTime = game.startTime {
            elapsedTime = Int(date.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate)
        }
    }
    
    private func newGame() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game(rows: 12, cols: 12, mines: 15)
        GameView(game: game)
            .previewInterfaceOrientation(.portrait)
    }
}
