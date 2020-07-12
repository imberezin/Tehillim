//
//  TehilimWidget.swift
//  TehilimWidget
//
//  Created by israel.berezin on 09/07/2020.
//

import WidgetKit
import SwiftUI
import Intents

struct ThilimEntry: TimelineEntry {
    
    var date: Date = Date()
    let text: String
    var chapterDivisionElement : [ChapterDivisionStoreElement]
}

struct ThilimTimelineProvider: TimelineProvider {
    
    typealias Entry = ThilimEntry
    
    @AppStorage("WidgetChaptersDivision", store: UserDefaults(suiteName: "group.es.vodafone.ONO"))
    var widgetChaptersDivisionData: Data = Data()
    
    var chapterDivisionElement : [ChapterDivisionStoreElement] =  [ChapterDivisionStoreElement (ChapterDivisionElement(start: "0", end: "0"), storeDate: Date())]
    
    var title: String = ""
    
    @ObservedObject var theilimMV = TheilimMV()
    
    init() {
        
        let fullHebDate = self.theilimMV.hebTodayDate()
        let hebDateArr = fullHebDate.split(separator: ",")
        if let hebTitle = hebDateArr.first{
            self.title = String(hebTitle)
        }
        self.chapterDivisionElement = self.buildChapterDivisionElementData()
    }
    
    func snapshot(with context: Context, completion: @escaping (Entry) -> ()) {
        let entry = ThilimEntry(text: self.title, chapterDivisionElement: self.chapterDivisionElement)
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = ThilimEntry(text: self.title, chapterDivisionElement: self.chapterDivisionElement)
        
        let date = Date()
        
        // let nextUpdateDate = date.tomorrow().startOfDay
        // Create a date that's 60 minutes in the future.
        
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 60, to: date)!
        
        
        // Create the timeline with the entry and a reload policy with the date
        // for the next update.
        let timeline = Timeline(
            entries:[entry],
            policy: .after(nextUpdateDate)
        )
        
        // Call the completion to pass the timeline to WidgetKit.
        completion(timeline)
       
    }
    
    func buildChapterDivisionElementData() -> [ChapterDivisionStoreElement] {
        
        var chapterDivisionElement : [ChapterDivisionStoreElement] =  [ChapterDivisionStoreElement (ChapterDivisionElement(start: "0", end: "0"), storeDate: Date())]
        if self.widgetChaptersDivisionData.count > 0 {
            print ("widgetChaptersDivisionData")
            guard let chaptersData = try? JSONDecoder().decode(ChapterDivisionStore.self, from: self.widgetChaptersDivisionData) else {
                return chapterDivisionElement
                
            }
            chapterDivisionElement = chaptersData
            
        }else{
            // can't be do, becuse when app load it set data to AppStorage
        }
        
        // check if data is valid
        let today = Date().startOfDay
        let saveTime = chapterDivisionElement.first!.storeDate.startOfDay
        print("today = \(today) \(today.timeIntervalSince1970)")
        print("saveTime = \(saveTime) \(saveTime.timeIntervalSince1970)")
        
        if today.timeIntervalSince1970 != saveTime.timeIntervalSince1970{
            print("Update Widget Data")
            chapterDivisionElement  =  self.theilimMV.dataToWidget()
        }
        
        return chapterDivisionElement
        
    }
}


struct TehilimWidgetView: View {
    
    let entry: ThilimTimelineProvider.Entry
    
    var body: some View {
        
        let today: ChapterDivisionElement = entry.chapterDivisionElement.first!.chapterDivisionElement
        let week: ChapterDivisionElement = entry.chapterDivisionElement.last!.chapterDivisionElement
        
        return VStack(spacing: 15.0) {
            VStack(spacing: 5.0) {
                Text("Theilim for")
                Text("\(entry.text)")
            }
            .font(.headline)
            
            HStack {
                Text("Today:")
                Spacer()
                Text("\(today.start) - \(today.end)")
                
            }.font(.subheadline)
            
            HStack {
                Text("Weekly:")
                Spacer()
                Text("\(week.start) - \(week.end)")
                
            }.font(.subheadline)
            
        }.padding(.all, 8)
    }
    
}


@main
struct TehilimWidget: Widget {
    private let kind = "TehilimWidget"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: ThilimTimelineProvider(), placeholder: Text("Tehilim Widget")) { entry in
            TehilimWidgetView(entry: entry)
        }
        
    }
}





/*
 struct Provider: IntentTimelineProvider {
 public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
 let entry = SimpleEntry(date: Date(), configuration: configuration)
 completion(entry)
 }
 
 public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
 var entries: [SimpleEntry] = []
 
 // Generate a timeline consisting of five entries an hour apart, starting from the current date.
 let currentDate = Date()
 for hourOffset in 0 ..< 5 {
 let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
 let entry = SimpleEntry(date: entryDate, configuration: configuration)
 entries.append(entry)
 }
 
 let timeline = Timeline(entries: entries, policy: .atEnd)
 completion(timeline)
 }
 }
 
 struct SimpleEntry: TimelineEntry {
 public let date: Date
 public let configuration: ConfigurationIntent
 }
 
 struct PlaceholderView : View {
 var body: some View {
 Text("Placeholder View")
 }
 }
 
 struct TehilimWidgetEntryView : View {
 var entry: Provider.Entry
 
 var body: some View {
 Text(entry.date, style: .time)
 .foregroundColor(Color.black)
 }
 }
 
 @main
 struct TehilimWidget: Widget {
 private let kind: String = "TehilimWidget"
 
 public var body: some WidgetConfiguration {
 IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
 TehilimWidgetEntryView(entry: entry)
 }
 .configurationDisplayName("My Widget")
 .description("This is an example widget.")
 }
 }
 
 
 
 //            if #available(iOS 12.0, *) {
 //
 //                do {
 //                    NSKeyedUnarchiver.setClass(ChapterDivisionElement.self, forClassName: "Tehilim2_0.ChapterDivisionElement")
 //                    guard let widgets = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(self.widgetChaptersDivisionData) as? ChapterDivision else {
 //                               fatalError("loadWidgetDataArray - Can't get Array")
 //                           }
 //
 //                    chapterDivisionElement = widgets //as! ChapterDivision
 //                    print(widgets)
 //                } catch let error as NSError {
 //                    print(error)
 //                }
 //
 //            } else {
 
 //                let widgets =  NSKeyedUnarchiver.unarchiveObject(with: self.widgetChaptersDivisionData) as! [ChapterDivisionElement]
 //                chapterDivisionElement = widgets
 //
 //            }
 
 */
