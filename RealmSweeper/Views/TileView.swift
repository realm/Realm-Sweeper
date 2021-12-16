//
//  TileView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 15/12/2021.
//

import SwiftUI

struct TileView: View {
    var body: some View {
        VStack(alignment: .center,spacing: 0) {
            Image("tile")
                .resizable()
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                Group {
                    TileView()
                        .frame(width: 25, height: 25)
                    TileView()
                        .frame(width: 50, height: 50)
                    TileView()
                        .frame(width: 100, height: 100)
                }
            )
        )
    }
}
