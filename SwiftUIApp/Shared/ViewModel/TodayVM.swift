//
//  TodayVM.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 07/07/2020.
//

import SwiftUI
import Combine


/*
 https://www.sefaria.org/api/calendars
 
 
 https://db.ou.org/zmanim/getCalendarData.php?mode=day&dateBegin=7%2F20%2F2020&lat=32.0678&lng=34.7647&timezone=Asia%2FJerusalem&israel_holidays=true&candles_offset=18&havdala_offset=42&_=1594106223554

 
 
 */


class TodayVM: ObservableObject {

    
    @Published var todayTimesVM = TodayTimesVM(todayTimes: TodayTimes(currentTime: "", engDateString: "xx/yy/zzzz", hebDateString: "Day Month Year", dayOfWeek: "", zmanim: Zmanim(sunrise: "", sofZmanTefilaGra: "", talisMa: "", tzeis595_Degrees: "", chatzos: "", minchaKetanaGra: "", plagMinchaMa: "", sofZmanShemaGra: "", sofZmanTefilaMa: "", tzeis42_Minutes: "", tzeis72_Minutes: "", tzeis850_Degrees: "", sunset: "", sofZmanShemaMa: "", alosMa: "", minchaGedolaMa: ""), dafYomi: DafYomi(masechta: "", daf: ""), specialShabbos: false, parshaShabbos: "", candleLightingShabbos: ""))
    
    @Published var todayLearnsVM: TodayLearnsVM = TodayLearnsVM(todayLearns: TodayLearns(date: "", timezone: "", calendarItems: [CalendarItem(title: DisplayValue(en: "", he: ""), displayValue: DisplayValue(en: "", he: ""), url: "", ref: "", order: 0, category: "")])
)
        
    
    func getTodayTimes() {
        
        let date = Date()
        let components = date.get(.day, .month, .year)
        if let day = components.day, let month = components.month, let year = components.year {
            print("day: \(day), month: \(month), year: \(year)")
                
            let url = URL(string: "https://db.ou.org/zmanim/getCalendarData.php?mode=day&dateBegin=\(month)%2F\(day)%2F\(year)&lat=31.76904&lng=35.21633&timezone=Asia%2FJerusalem&israel_holidays=true&candles_offset=18&havdala_offset=42&_=1594106223554")

            let task = URLSession.shared.todayTimesTask(with: url!) { todayTimes, response, error in
             if let todayTimes = todayTimes {
                print(todayTimes)
                DispatchQueue.main.async {
                    self.todayTimesVM = TodayTimesVM(todayTimes: todayTimes)
               }
             }else{
                print("problem")
             }
           }
           task.resume()
        }
        
    }
    
    func getTodayLearns(){
        let url = URL(string:"https://www.sefaria.org/api/calendars")
        
        let task = URLSession.shared.todayLearnsTask(with: url!) { todayLearns, response, error in
             if let todayLearns = todayLearns {
                print(todayLearns)
                DispatchQueue.main.async {

                    self.todayLearnsVM = TodayLearnsVM(todayLearns: todayLearns)
                }
             }
           }
           task.resume()

        
    }

}
