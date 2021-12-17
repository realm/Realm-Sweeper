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
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            GeometryReader { g in
                HStack(alignment: .bottom, spacing: 0) {
                    Spacer()
                    Text(String(format: "%03d", count))
                        .font(Font.custom("CrystalItalic-", size: g.size.height * 1.2))
                        .foregroundColor(count >= 0 ? .red : .orange)
                    Spacer()
                }
            }
        }
        .background(.black)
    }
}

struct LEDCounter_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme (
                Group {
                    LEDCounter(count: 0)
                        .frame(width: 150, height: 50)
                    LEDCounter(count: 12)
                        .frame(width: 150, height: 50)
                    LEDCounter(count: 123)
                        .frame(width: 150, height: 50)
                    LEDCounter(count: 0)
                        .frame(width: 150, height: 50)
                    LEDCounter(count: 12)
                        .frame(width: 200, height: 100)
                    LEDCounter(count: 888)
                        .frame(width: 150, height: 50)
                }
            )
        )
    }
}
