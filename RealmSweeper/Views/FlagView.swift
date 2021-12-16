//
//  FlagView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 15/12/2021.
//

import SwiftUI

struct FlagView: View {
    var body: some View {
        VStack(alignment: .center,spacing: 0) {
            Image("flag")
                .resizable()
        }
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                Group {
                    FlagView()
                        .frame(width: 25, height: 25)
                    FlagView()
                        .frame(width: 50, height: 50)
                    FlagView()
                        .frame(width: 100, height: 100)
                }
            )
        )
    }
}
