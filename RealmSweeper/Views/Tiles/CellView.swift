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
        if cell.isExposed || gameStatus == .won {
            Group {
                if cell.isMine {
                    MineView(exploded: cell.hasExploded)
                } else {
                    MineCountView(count: cell.numMineNeigbours)
                }
            }
            .background(.gray)
            .border(.black)
        } else {
            ZStack {
                if gameStatus == .lost && cell.isMine && !cell.isFlagged {
                    MineView()
                        .background(.gray)
                        .border(.black)
                } else if gameStatus == .lost && cell.isMine && cell.isFlagged {
                    TileView()
                    FlagView(mistake: false)
                }
                else if gameStatus == .lost && cell.isFlagged {
                    TileView()
                    FlagView(mistake: !cell.isMine)
                } else {
                    TileView()
                    if cell.isFlagged {
                        FlagView(mistake: false)
                    }
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
