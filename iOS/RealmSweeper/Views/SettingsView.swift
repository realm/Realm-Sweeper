//
//  SettingsView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 16/12/2021.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("numRows") var numRows = 10
    @AppStorage("numColumns") var numColumns = 10
    @AppStorage("numMines") var numMines = 15
    
    @Binding var isPresented: Bool
    var body: some View {
        Form {
            Section("Board Options") {
                HStack {
                    Stepper("Number of rows", value: $numRows, in: 1...24)
                    Text(numRows.description)
                    Spacer()
                }
                HStack {
                    Stepper("Number of columns", value: $numColumns, in: 1...24)
                    Text(numColumns.description)
                    Spacer()
                }
                HStack {
                    Stepper("Number of mines", value: $numMines, in: 1...60)
                    Text(numMines.description)
                    Spacer()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
