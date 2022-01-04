//
//  BoardView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 15/12/2021.
//

import SwiftUI
import RealmSwift

struct BoardView: View {
    @ObservedRealmObject var board: Board
    @Binding var gameStatus: GameStatus
    var newMove: () -> Void
    
    var body: some View {
        let numRows = board.rows.count > 0 ? board.rows.count : 1
        let numCols = numRows > 0 ? board.rows[0].cells.count : 1
        
        return VStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    ForEach(board.rows.indices) { row in
                        HStack(spacing: 0) {
                            Spacer()
                            ForEach(board.rows[row].cells.indices) { col in
                                CellView(cell: board.rows[row].cells[col], gameStatus: gameStatus)
                                    .frame(
                                        width: min(geo.size.width / CGFloat(numCols), geo.size.height / CGFloat(numRows)),
                                        height: min(geo.size.width / CGFloat(numCols), geo.size.height / CGFloat(numRows))
                                    )
                                    .border(.gray, width: 1.0)
                                    .onTapGesture() {
                                        expose(row: row, col: col)
                                    }
                                    .onLongPressGesture(minimumDuration: 0.1) {
                                        flag(row: row, col: col)
                                    }
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    private func expose(row: Int, col: Int) {
        if gameStatus == .inProgress || gameStatus == .notStarted {
            if !board.rows[row].cells[col].isExposed {
                if board.rows[row].cells[col].isMine {
                    $board.rows[row].cells[col].hasExploded.wrappedValue = true
                    $board.rows[row].cells[col].isExposed.wrappedValue = true
                }
                let coordsToExpose = board.findCellsToExpose(row: row, col: col)
                coordsToExpose.forEach() { coord in
                    $board.rows[coord.row].cells[coord.col].isExposed.wrappedValue = true
                }
                $board.rows[row].cells[col].isExposed.wrappedValue = true
                if board.rows[row].cells[col].isFlagged {
                    $board.rows[row].cells[col].isFlagged.wrappedValue = false
                }
                newMove()
            }
        }
    }
    
    private func flag(row: Int, col: Int) {
        hapticFeedback(true)
        if gameStatus == .notStarted {
            gameStatus = .inProgress
        }
        if gameStatus == .inProgress {
            if !board.rows[row].cells[col].isExposed {
                $board.rows[row].cells[col].isFlagged.wrappedValue.toggle()
                newMove()
            }
        }
    }
    
    func hapticFeedback(_ isSuccess: Bool) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(isSuccess ? .success : .error)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game(rows: 12, cols: 12, mines: 15)
        return BoardView(board: game.board!, gameStatus: .constant(.inProgress), newMove: {})
    }
}
