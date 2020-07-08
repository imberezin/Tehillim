//
//  PersistentStore.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI
import Combine
import CoreData


class PersistentStore: NSObject {
            
    static let shared = PersistentStore()
        
        
        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "TehilimDB")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            container.viewContext.automaticallyMergesChangesFromParent = true

            return container
        }()
        
        
        func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

    

}
