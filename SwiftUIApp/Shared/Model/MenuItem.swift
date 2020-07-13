//
//  MenuItem.swift
//  iOS
//
//  Created by israel.berezin on 09/07/2020.
//

import Foundation
import SwiftUI



enum PrayerMode: Int {
    case Single=0, Monthly, Weekly, Book, Personal,Spaicel,Elul, Widget, Section, Search, FavoriteList, FavoriteAdd, Other, TodayTimes, TodayLeran, AboutUs, Info
}



class MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let prayerMode: PrayerMode
    let isSection: Bool
    let children : [MenuItem]?
    
    init(name: String, prayerMode: PrayerMode, isSection: Bool = false, children:[MenuItem]? = nil){
        self.name = name
        self.prayerMode = prayerMode
        self.isSection = isSection
        self.children = children
    }
    
}




extension MenuItem: CustomStringConvertible {
   var description: String {
    return "name = \(String(describing: name)), children = \(String(describing: children?.count)))"
   }
}
