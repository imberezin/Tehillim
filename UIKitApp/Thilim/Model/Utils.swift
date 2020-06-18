//
//  Utils.swift
//  Thilim
//
//  Created by Israel Berezin on 28/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

struct AllThilimDivision
{
    let start: String
    let end: String
    let divisionType: PrayerMode
    var birthday : Date
    
    enum ErrorType: Error {
        case noPlistFile
        case cannotReadFile
    }
    
    // Load all the elements from the plist file
    static func loadFromPlist(selectedMode: PrayerMode) throws -> [AllThilimDivision] {
        // First we need to find the plist
        
        var fileName : String = ""
        
        switch selectedMode  {
        case .Weekly:
            fileName = "WeeklyThilim"
            break
        case .Book:
            fileName = "BoooksThilim"
            break
        case .Monthly:
            fileName = "MonthlyThilim"
            break
        case .Personal:
            fileName = "personThilim"
            break
        default:
            break
        }
        
        // Initialize the array
        var elements: [AllThilimDivision] = []
        
        if Plist(name: fileName) != nil{
            let plist = Plist(name: fileName)
            let array = (plist?.getValuesInPlistFile())!
            
            //        guard let file = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            //            throw ErrorType.noPlistFile
            //        }
            //
            //        // Then we read it as an array of dict
            //        guard let array = NSArray(contentsOfFile: file) as? [[String: AnyObject]] else {
            //            throw ErrorType.cannotReadFile
            //        }
            
            
            // For each dictionary
            for dict in array {
                // We implement the element
                let element = AllThilimDivision.from(dict: dict as! [String : AnyObject])
                // And add it to the array
                elements.append(element)
            }
            
        }
        // Return all elements
        
        return elements
        
    }
    
    static func loadFromArray(array: Array<AnyObject>) throws -> [AllThilimDivision] {
        // Initialize the array
        var elements: [AllThilimDivision] = []
        
        // For each dictionary
        for dict in array {
            // We implement the element
            let element = AllThilimDivision.from(dict: dict as! [String : AnyObject])
            // And add it to the array
            elements.append(element)
        }
        
        // Return all elements
        return elements
        
    }
    /// Create an element corresponding to the given dict
    static func from(dict: [String: AnyObject]) -> AllThilimDivision {
        let start : String = dict["Start"] as! String
        let end : String = dict["End"] as! String
        var birthday: String = ""
        
        if dict["birthday"] != nil {
            birthday = dict["birthday"] as! String
            
        }
        // convert string to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy" //Your New Date format as per requirement change it own
        if (birthday.characters.count == 0){
            birthday = "01-01-2000"
        }
        let date: Date = dateFormatter.date(from: birthday)!
            //according to date format your date string
        print(date) //New formatted Date string
        
        // convert NDsate to Date
        //let d: Date = Date(timeIntervalSinceReferenceDate: birthday.timeIntervalSinceReferenceDate)
        return AllThilimDivision(start: start,
                                 end: end,
                                 divisionType:.Weekly,
                                 birthday:date)
    }
}


struct Plist {
    enum PlistError: Error {
        case FileNotWritten
        case FileDoesNotExist
    }
    
    var name:String = ""
    
    var sourcePath:String? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else { return .none }
        return path
    }
    
    var destPath:String? {
        guard sourcePath != .none else { return .none }
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (dir as NSString).appendingPathComponent("\(name).plist")
    }
    
    init?(name:String) {
        //1
        self.name = name
        //2
        let fileManager = FileManager.default
        //3
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExists(atPath: source) else { return nil }
        //4
        if !fileManager.fileExists(atPath: destination) {
            //5
            do {
                try fileManager.copyItem(atPath: source, toPath: destination)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    func addValuesToPlistFile(array:NSMutableArray) throws {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            if !array.write(toFile: destPath!, atomically: false) {
                print("File not written successfully")
                throw PlistError.FileNotWritten
            }
        } else {
            throw PlistError.FileDoesNotExist
        }
    }
    
    func getValuesInPlistFile() -> NSMutableArray?{
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            guard let dict = NSMutableArray(contentsOfFile: destPath!) else { return .none }
            return dict
        } else {
            return .none
        }
    }
    
}
class Utils: NSObject {
    
}
