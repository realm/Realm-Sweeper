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
    
    var body: some View {
        if cell.isExposed {
            Group {
                if cell.isBomb {
                    BombView(exploded: cell.hasExploded)
                } else {
                    BombCountView(count: cell.numBombNeigbours)
                }
            }
            .background(.gray)
            .border(.black)
        } else {
            ZStack {
                TileView()
                if cell.isFlagged {
                    FlagView()
                }
            }
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                CellView(cell: Cell(isBomb: false, numBombNeigbours: 1))
            )
        )
    }
}
