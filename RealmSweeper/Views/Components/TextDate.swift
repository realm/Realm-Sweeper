//
//  TextDate.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 15/12/2021.
//

import SwiftUI

struct TextDate: View {
    var date: Date
    
    init(_ date: Date) {
        self.date = date
    }
    
    private var isLessThanOneMinute: Bool { date.timeIntervalSinceNow > -60 }
    private var isLessThanOneDay: Bool { date.timeIntervalSinceNow > -60 * 60 * 24 }
    private var isLessThanOneWeek: Bool { date.timeIntervalSinceNow > -60 * 60 * 24 * 7}
    private var isLessThanOneYear: Bool { date.timeIntervalSinceNow > -60 * 60 * 24 * 365}
    
    var body: some View {
        if isLessThanOneMinute {
            Text(date.formatted(.dateTime.hour().minute().second()))
        } else {
            if isLessThanOneDay {
                Text(date.formatted(.dateTime.hour().minute()))
            } else {
                if isLessThanOneWeek {
                    Text(date.formatted(.dateTime.weekday(.wide).hour().minute()))
                } else {
                    if isLessThanOneYear {
                        Text(date.formatted(.dateTime.month().day()))
                    } else {
                        Text(date.formatted(.dateTime.year().month().day()))
                    }
                }
            }
        }
    }
}

struct TextDate_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextDate(Date(timeIntervalSinceNow: -60 * 60 * 24 * 365)) // 1 year ago
            TextDate(Date(timeIntervalSinceNow: -60 * 60 * 24 * 7))   // 1 week ago
            TextDate(Date(timeIntervalSinceNow: -60 * 60 * 24))       // 1 day ago
            TextDate(Date(timeIntervalSinceNow: -60 * 60))            // 1 hour ago
            TextDate(Date(timeIntervalSinceNow: -60))                 // 1 minute ago
            TextDate(Date())                                          // Now
        }
    }
}
