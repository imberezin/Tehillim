//
//  TodayLearnsVM.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 07/07/2020.
//

import Foundation

class TodayLearnsVM: Identifiable {
    
    let id = UUID()
    
    private let todayLearns: TodayLearns

    
    init (todayLearns: TodayLearns){
        self.todayLearns = todayLearns
    }

    var calendarItem: [CalendarItem]{
        return self.todayLearns.calendarItems!
    }
    
    
    
}
