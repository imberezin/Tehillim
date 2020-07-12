//
//  ChapterDivisionStoreElement.swift
//  iOS
//
//  Created by israel.berezin on 12/07/2020.
//

import Foundation

typealias ChapterDivisionStore = [ChapterDivisionStoreElement]

class ChapterDivisionStoreElement: NSObject, Codable {
    
    let chapterDivisionElement : ChapterDivisionElement
    let storeDate: Date
 
    init(_ chapterDivisionElement : ChapterDivisionElement, storeDate: Date) {
        self.chapterDivisionElement = chapterDivisionElement
        self.storeDate = storeDate
    }
}
