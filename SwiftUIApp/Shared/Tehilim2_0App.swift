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

    @SceneBuilder var body: some Scene {
        WindowGroup {
            #if os(macOS)
                ContentMacView()
                    .environment(\.managedObjectContext, context)
            #else
                ContentView()
                    .environment(\.managedObjectContext, context)
            #endif
        }
        #if os(macOS)
        Settings {
            SettingsView() // Passed as an observed object.
        }
        #endif

//        #if os(macOS)
//        Settings {
//            ContentMacView()
//
//        }
//        #endif
    }
}

struct Tehilim2_0App_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
