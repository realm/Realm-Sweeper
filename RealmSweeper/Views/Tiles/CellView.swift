//
//  CellView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import SwiftUI
import RealmSwift

struct CellView: View {
    @ObservedRealmObject var cell: Cell
    let gameStatus: GameStatus
    
    var body: some View {
        if gameStatus == .won {
            if cell.isExposed && !cell.isFlagged {
                MineCountView(count: cell.numMineNeigbours)
            } else {
                FlagView(mistake: false)
            }
        }
        if gameStatus == .lost {
            if cell.isFlagged {
                FlagView(mistake: !cell.isMine)
            } else if cell.isMine {
                MineView(exploded: cell.isExposed)
            } else {
                if cell.isExposed {
                    MineCountView(count: cell.numMineNeigbours)
                } else {
                    TileView()
                }
            }
        }
        if gameStatus == .notStarted {
            TileView()
        }
        if gameStatus == .inProgress {
            if cell.isExposed {
                if cell.isMine {
                    MineView()
                } else {
                    MineCountView(count: cell.numMineNeigbours)
                }
            } else {
                if cell.isFlagged {
                    FlagView(mistake: false)
                } else {
                    TileView()
                }
            }
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        let cell = Cell(isMine: false, numMineNeigbours: 0)
        cell.isFlagged = true
        return _PreviewNoDevice(
            _PreviewColorScheme (
                CellView(cell: cell, gameStatus: .lost)
            )
        )
            .frame(width: 100.0, height: 100.0)
    }
}
