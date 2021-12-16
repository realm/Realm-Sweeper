//
//  RealmSweeperApp.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import SwiftUI
import RealmSwift

let realmApp = RealmSwift.App(id: "realmsweeper-xxxxx")

@main
struct RealmSweeperApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
