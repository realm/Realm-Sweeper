//
//  StatusButton.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 16/12/2021.
//

import SwiftUI

struct StatusButton: View {
    let status: String
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Image("tile")
                    .resizable()
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        GeometryReader { geo in
                            Text(status)
                                .font(.system(size: geo.size.height * 0.7))
                        }
                        .padding([.top], 8)
                        .padding([.leading], 4)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct StatusButton_Previews: PreviewProvider {
    static var previews: some View {
        _PreviewNoDevice(
            _PreviewColorScheme(
                StatusButton(status: "😎")
                    .frame(width: 100, height: 100, alignment: .center)
            )
        )
    }
}
