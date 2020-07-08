//
//  Tehilim2_0App.swift
//  Shared
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI
import CoreData

@main
struct Tehilim2_0App: App {
    
    let context = PersistentStore.shared.persistentContainer.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context)
        }
    }
}
