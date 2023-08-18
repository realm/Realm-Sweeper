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
    @Environment(\.realm) var realm
    
    @AppStorage("numRows") var numRows = 10
    @AppStorage("numColumns") var numColumns = 10
    @AppStorage("numMines") var numMines = 15
    
    let username: String
    
    @State private var startGame = false
    @State private var showingSettings = false
    @State private var game: Game?
    @State private var inProgress = false
    
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
                            GameSummaryView(game: game)
                        }
                    }
                }
            }
            if let game = game {
                NavigationLink(destination: GameView(game: game), isActive: $startGame) {}
            }
            NavigationLink(destination: SettingsView(isPresented: $showingSettings), isActive: $showingSettings) {}
            if inProgress {
                ProgressView()
            }
        }
        .navigationBarTitle("Games", displayMode: .inline)
        .onAppear(perform: setSubscriptions)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showingSettings.toggle() }) {
                    Image(systemName: "gear")
                }
            }
        }
    }
    
    private func setSubscriptions() {
        let subscriptions = realm.subscriptions
        if subscriptions.first(named: "games") == nil {
            inProgress = true
            subscriptions.update() {
            subscriptions.append(QuerySubscription<Game>(name: "games") { game in
                game.username == username && (
                    game.gameStatus == GameStatus.inProgress ||
                    game.gameStatus == GameStatus.notStarted ||
                    game.startTime > Calendar.current.date(byAdding: .day, value: -7, to: Date())
                )
            })
            } onComplete: { _ in
                Task { @MainActor in
                    inProgress = false
                }
            }
        }
    }
    
    private func createGame() {
        numMines = min(numMines, numRows * numColumns)
        game = Game(username: username, rows: numRows, cols: numColumns, mines: numMines)
        if let game = game {
            $games.append(game)
        }
        startGame  = true
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView(username: "Andrew")
    }
}
