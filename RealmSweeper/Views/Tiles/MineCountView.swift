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
        // TODO: Fix these colors
        switch count {
        case 0:
            return .gray
        case 1:
            return .blue
        case 2:
            return .green
        case 3:
            return .red
        case 4:
            return .purple
        case 5:
            return .brown
        case 6:
            return .teal
        case 7:
            return .black
        case 8:
            return .cyan
        default:
            return .red
        }
    }
    
    var body: some View {
        GeometryReader { g in
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Text("\(count)")
                    .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.8 : g.size.height * 0.8))
                    .foregroundColor(color)
                Spacer()
            }
            .background(.gray)
        }
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
