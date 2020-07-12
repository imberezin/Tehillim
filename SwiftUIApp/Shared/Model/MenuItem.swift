//
//  MenuItem.swift
//  iOS
//
//  Created by israel.berezin on 09/07/2020.
//

import Foundation
import SwiftUI

class MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let prayerMode: PrayerMode
    
    init(name: String, prayerMode: PrayerMode){
        self.name = name
        self.prayerMode = prayerMode
    }
    
}

