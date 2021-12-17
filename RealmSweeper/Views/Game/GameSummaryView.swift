//
//  GameSummaryView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 17/12/2021.
//

import SwiftUI

struct GameSummaryView: View {
    let game: Game
    var body: some View {
        VStack {

        }
    }
}

struct GameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game()
        return _PreviewNoDevice (
            _PreviewColorScheme (
                GameSummaryView(game: game)
                    .padding()
            )
        )
    }
}
