//
//  dateExtension.swift
//  iOS
//
//  Created by israel.berezin on 12/07/2020.
//

import Foundation
//import UIKit


extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    
        func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
            return calendar.dateComponents(Set(components), from: self)
        }

        func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(component, from: self)
        }
    

            
        
        func midnight() -> Date {
            let cal = Calendar(identifier: .gregorian)
            return cal.startOfDay(for: self)
        }
        
        func tomorrow() -> Date {
            
            let calendar = Calendar.current
            // Use the following line if you want midnight UTC instead of local time
            //calendar.timeZone = TimeZone(secondsFromGMT: 0)
            let today = Date()
            let midnight = calendar.startOfDay(for: today)
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!

//            let midnightEpoch = midnight.timeIntervalSince1970
//            let tomorrowEpoch = tomorrow.timeIntervalSince1970
            return tomorrow
        }

    var startOfDay : Date {
        var calendar = Calendar.current
        calendar.timeZone = .current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    var endOfDay : Date {
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(-1))!
    }

}


