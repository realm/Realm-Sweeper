//
//  LEDCounter.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 16/12/2021.
//

import SwiftUI

struct LEDCounter: View {
    let count: Int
    var body: some View {
        VStack {
            GeometryReader { g in
                HStack(alignment: .bottom, spacing: 0) {
                    Text(String(format: "%03d", count))
                        .font(Font.custom("CrystalItalic-", size: min(g.size.height, g.size.width / 2.2) * 1.2))
                        .foregroundColor(count >= 0 ? .red : .orange)
                }
                .frame(width: min(150, g.size.width))
            }
        }
        .frame(maxWidth: 150)
        .padding(.top, 13)
        .background(.black)
    }
}

struct LEDCounter_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                Group {
                    LEDCounter(count: 0)
                        .frame(width: 150, height: 70)
                    LEDCounter(count: 12)
                        .frame(width: 150, height: 70)
                    LEDCounter(count: 123)
                        .frame(width: 150, height: 70)
                    LEDCounter(count: 0)
                        .frame(width: 150, height: 70)
                    LEDCounter(count: 12)
                        .frame(width: 200, height: 100)
                    LEDCounter(count: 888)
                        .frame(width: 150, height: 70)
                }
            )
        )
    }
}
