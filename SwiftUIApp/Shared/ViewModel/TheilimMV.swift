//
//  TheilimMV.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI
import Combine
import WidgetKit


class TheilimMV: ObservableObject {

    let menuItem : MenuItem
    
    @Published var chapterDivision: ChapterDivisionElement? = nil
    
    @AppStorage("WidgetChaptersDivision", store: UserDefaults(suiteName: "group.es.vodafone.ONO"))
    var widgetChaptersDivisionData: Data = Data(count: 0)
//
    
    init() {
        self.menuItem = MenuItem(name: "Widget", prayerMode: .Widget)
    }
    
    init(menuItem : MenuItem) {
        self.menuItem = menuItem
        
        self.dataToWidget()
        WidgetCenter.shared.reloadAllTimelines()

        self.prepareThilimList()
    }
    
    func prepareThilimList(){
        switch self.menuItem.prayerMode {
        case .Monthly:
            print("Monthly")
            self.prepareMonthly()
        case .Weekly:
            print("Weekly")
            self.prepareWeekly()
        case .Book:
            print("Book")
            self.prepareAllBook()
        case .Personal:
            print("Personal")
        case .Elul:
            print("Elul")
        case .Single:
            print("Single")
        case .Spaicel:
            print("Spaicel")
        default:
            print("Widget")

        }
    }
    
    func prepareMonthly(){
        let hebDate : String = self.getHebrewDate(date: Date())
        print("hebDate = \(hebDate)")
        let parts: Array = hebDate.components(separatedBy: " ")
        let selectDay = (Int(parts[0])!) - 1 // our index start form 0 and days start from 1!
        print("selectDay = \(selectDay)")
        
        let chapterDivision = self.loadJson(fileName: "MonthlyThilim")
        let todayChapterDivision = chapterDivision[selectDay]

        if (selectDay == 28){ //check if month is 29 or 30  days
            let hebNextDate : String = self.getHebrewDate(date: self.dateByAddingDays(inDays: 1))
            let parts1: Array = hebNextDate.components(separatedBy: " ")
            print("hebNextDate = \(hebNextDate)")
            
            // it 29 days in month need say also missing day
            let nextDay = (Int(parts1[0])!) - 1
            if (nextDay == 0) {
                let nextChapterDivision = chapterDivision[selectDay+1]
                self.chapterDivision = ChapterDivisionElement(start: todayChapterDivision.start, end: nextChapterDivision.end)
            }else{
                self.chapterDivision = ChapterDivisionElement(start: todayChapterDivision.start, end: todayChapterDivision.end)
            }
        }else{
            self.chapterDivision = ChapterDivisionElement(start: todayChapterDivision.start, end: todayChapterDivision.end)
        }
        
    }
    
    func prepareWeekly(){
        let selectDay  = (Date().dayNumberOfWeek()!)-1
        let chapterDivision = self.loadJson(fileName: "WeeklyThilim")
        self.chapterDivision = chapterDivision[selectDay]
    }
    
    func prepareAllBook(){
        self.chapterDivision = ChapterDivisionElement(start: "1", end: "149")
    }

    
    
    func loadJson(fileName: String) -> ChapterDivision {
        
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        let data = try? Data(contentsOf: url!)
        
        let chapterDivision = try! ChapterDivision(data: data!)
        print(chapterDivision.count)

        return chapterDivision
        //
    }

    
    public func getHebrewDate(date:Date) -> String {
        let hebrew = NSCalendar(identifier: NSCalendar.Identifier.hebrew)

        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.short
        
        formatter.timeStyle = DateFormatter.Style.short
        
        formatter.calendar = hebrew as Calendar?
        
        formatter.locale = Locale(identifier: "en")
        let str:String = formatter.string(from: date as Date)
        
        print(str)
        return (str)
    }

    func dateByAddingDays(inDays:NSInteger)->Date{
        let today = Date()
        return Calendar.current.date(byAdding: .day, value: inDays, to: today)!
    }

}

extension TheilimMV {
    
    func hebTodayDate() -> String{
        let hebDate : String = self.getHebrewDate(date: Date())
        return hebDate
    }
    
    @discardableResult
    func dataToWidget() -> [ChapterDivisionStoreElement]{
        
        let hebDate : String = self.getHebrewDate(date: Date())
        print("hebDate = \(hebDate)")
        let parts: Array = hebDate.components(separatedBy: " ")
        let selectDay = (Int(parts[0])!) - 1 // our index start form 0 and days start from 1!
        print("selectDay = \(selectDay)")
        
        let chapterDivision = self.loadJson(fileName: "MonthlyThilim")
        let todayChapterDivision: ChapterDivisionElement = chapterDivision[selectDay]

        
        
        let selectWeeklyDay  = (Date().dayNumberOfWeek()!)-1
        let weeklyChapters = self.loadJson(fileName: "WeeklyThilim")
        let weeklyChapterDivision: ChapterDivisionElement = weeklyChapters[selectWeeklyDay]
        
        
        let todayChapterDivisionStoreElement = ChapterDivisionStoreElement(todayChapterDivision, storeDate: Date())
        
        let weeklyChapterDivisionStoreElement = ChapterDivisionStoreElement(weeklyChapterDivision, storeDate: Date())

        let array = [todayChapterDivisionStoreElement, weeklyChapterDivisionStoreElement]
        
        guard let chaptersData = try? JSONEncoder().encode(array) else {
            return array
        }
        
        self.widgetChaptersDivisionData = chaptersData
        
        return array
    }
}


//do {
//            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
//            self.widgetChaptersDivisionData = encodedData
//        } catch let error as NSError {
//            print(error)
//        }
