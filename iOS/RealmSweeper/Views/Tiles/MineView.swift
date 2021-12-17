//
//  MineView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 14/12/2021.
//

import SwiftUI

struct MineView: View {
    var exploded = false
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("mine")
                .resizable()
        }
        .background(exploded ? .red : .gray)
    }
}

struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                Group {
                    MineView()
                        .frame(width: 25, height: 25)
                    MineView(exploded: true)
                        .frame(width: 50, height: 50)
                    MineView()
                        .frame(width: 100, height: 100)
                }
            )
        )
    }
}
