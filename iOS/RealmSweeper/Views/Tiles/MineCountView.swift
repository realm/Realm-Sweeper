//
//  MineCountView.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import SwiftUI

struct MineCountView: View {
    let count: Int
    
    var color: Color {
        switch count {
        case 0:
            return Color("Tile")
        case 1:
            return Color("One")
        case 2:
            return Color("Two")
        case 3:
            return Color("Three")
        case 4:
            return Color("Four")
        case 5:
            return Color("Five")
        case 6:
            return Color("Six")
        case 7:
            return Color("Seven")
        case 8:
            return Color("Eight")
        default:
            return .red
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            GeometryReader { g in
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    Text("\(count)")
                        .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.8 : g.size.height * 0.8))
                        .foregroundColor(color)
                    Spacer()
                }
            }
        }
        .background(Color("Tile"))
    }
}

struct MineCountView_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                Group {
                    MineCountView(count: 0)
                        .frame(width: 50, height: 50)
                    MineCountView(count: 1)
                        .frame(width: 50, height: 50)
                    MineCountView(count: 2)
                        .frame(width: 50, height: 50)
                    MineCountView(count: 3)
                        .frame(width: 50, height: 50)
                    MineCountView(count: 4)
                        .frame(width: 100, height: 100)
                    MineCountView(count: 5)
                        .frame(width: 50, height: 50)
                }
            )
        )
    }
}
