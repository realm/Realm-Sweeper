//
//  FlagView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 15/12/2021.
//

import SwiftUI

struct FlagView: View {
    var mistake: Bool
    
    var body: some View {
        ZStack {
            TileView()
            VStack(alignment: .center,spacing: 0) {
                Image(mistake ? "wrong-flag" : "flag")
                    .resizable()
            }
        }
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                Group {
                    FlagView(mistake: false)
                        .frame(width: 25, height: 25)
                    FlagView(mistake: true)
                        .frame(width: 50, height: 50)
                    FlagView(mistake: false)
                        .frame(width: 100, height: 100)
                }
            )
        )
    }
}
