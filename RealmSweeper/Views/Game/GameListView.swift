//
//  GameListView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import SwiftUI
import RealmSwift

struct GameListView: View {
    @ObservedResults(Game.self, sortDescriptor: SortDescriptor(keyPath: "startTime", ascending: false)) var games
    
    @AppStorage("numRows") var numRows = 10
    @AppStorage("numColumns") var numColumns = 10
    @AppStorage("numMines") var numMines = 15
    
    @State private var startGame = false
    @State private var isWaiting = true
    @State private var showingSettings = false
    
    @State private var game: Game?
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: createGame) {
                    Text("New Game")
                }
                .buttonStyle(.borderedProminent)
                List {
                    ForEach(games) { game in
                        NavigationLink(destination: GameView(game: game)) {
                            Text(game._id.stringValue)
                        }
                    }
                }
            }
            if isWaiting {
                ProgressView()
                    .onAppear(perform: waitABit)
            }
            if let game = game {
                NavigationLink(destination: GameView(game: game), isActive: $startGame) {}
            }
            NavigationLink(destination: SettingsView(isPresented: $showingSettings), isActive: $showingSettings) {}
        }
        .navigationBarTitle("Games", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showingSettings.toggle() }) {
                    Image(systemName: "gear")
                }
            }
        }
    }
    
    private func waitABit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isWaiting = false
        }
    }
    
    private func createGame() {
        numMines = min(numMines, numRows * numColumns)
        game = Game(rows: numRows, cols: numColumns, mines: numMines)
        if let game = game {
            $games.append(game)
        }
        startGame  = true
    }
}

//struct GameListView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameListView()
//    }
//}
