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
    let gameOver: Bool
//    var gameOver: (_: Bool) -> Void
    var newMove: () -> Void
    
    var body: some View {
        let numRows = board.rows.count > 0 ? board.rows.count : 1
        let numCols = numRows > 0 ? board.rows[0].cells.count : 1
        
        return VStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    ForEach(board.rows.indices) { row in
                        HStack(spacing: 0) {
                            ForEach(board.rows[row].cells.indices) { col in
                                CellView(cell: board.rows[row].cells[col])
                                    .frame(
                                        width: min(geo.size.width / CGFloat(numCols), geo.size.height / CGFloat(numRows)),
                                        height: min(geo.size.width / CGFloat(numCols), geo.size.height / CGFloat(numRows))
                                    )
                                    .onTapGesture() {
                                        expose(row: row, col: col)
                                    }
                                    .onLongPressGesture(minimumDuration: 0.1) {
                                        flag(row: row, col: col)
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func expose(row: Int, col: Int) {
        if !gameOver {
            if !board.rows[row].cells[col].isExposed {
                if board.rows[row].cells[col].isBomb {
                    $board.rows[row].cells[col].hasExploded.wrappedValue = true
                    $board.rows[row].cells[col].isExposed.wrappedValue = true
                }
                // TODO: expose neighbouring cells
                let coordsToExpose = board.findCellsToExpose(row: row, col: col)
                coordsToExpose.forEach() { coord in
                    $board.rows[coord.row].cells[coord.col].isExposed.wrappedValue = true
                }
                $board.rows[row].cells[col].isExposed.wrappedValue = true
                newMove()
            }
        }
    }
    
    private func flag(row: Int, col: Int) {
        if !gameOver {
            if !board.rows[row].cells[col].isExposed {
                $board.rows[row].cells[col].isFlagged.wrappedValue.toggle()
                newMove()
            }
        }
    }
}

//struct BoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardView()
//    }
//}
