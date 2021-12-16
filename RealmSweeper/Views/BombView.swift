//
//  BombView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 14/12/2021.
//

import SwiftUI

struct BombView: View {
    var exploded = false
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("mine")
                .resizable()
        }
        .background(exploded ? .red : .gray)
    }
}

struct BombView_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                Group {
                    BombView()
                        .frame(width: 25, height: 25)
                    BombView(exploded: true)
                        .frame(width: 50, height: 50)
                    BombView()
                        .frame(width: 100, height: 100)
                }
            )
        )
    }
}
