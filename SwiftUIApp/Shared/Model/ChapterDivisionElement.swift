//
//  ChapterDivisionElement.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 01/07/2020.
//

// To parse the JSON, add this file to your project and do:
//
//   let chapterDivision = try ChapterDivision(json)

import Foundation




// MARK: - ChapterDivisionElement
class ChapterDivisionElement: NSObject, Codable, NSCoding {
    
    
    func encode(with coder: NSCoder) {
        coder.encode(self.start, forKey: "start")
        coder.encode(self.end, forKey: "end")
    }
    
    required init?(coder: NSCoder) {
        self.start = coder.decodeObject(forKey: "start") as! String
        self.end = coder.decodeObject(forKey: "end") as! String
    }
    
    var start, end: String
    
    var startAt: Int{
        Int(start) ?? 0
    }

    var endIn: Int{
        Int(end) ?? 0
    }

    enum CodingKeys: String, CodingKey {
        case start = "Start"
        case end = "End"
    }

    init(start: String, end: String) {
        self.start = start
        self.end = end
    }
}

// MARK: ChapterDivisionElement convenience initializers and mutators

extension ChapterDivisionElement {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ChapterDivisionElement.self, from: data)
        self.init(start: me.start, end: me.end)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        start: String? = nil,
        end: String? = nil
    ) -> ChapterDivisionElement {
        return ChapterDivisionElement(
            start: start ?? self.start,
            end: end ?? self.end
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias ChapterDivision = [ChapterDivisionElement]

extension Array where Element == ChapterDivision.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ChapterDivision.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
//
//extension ChapterDivisionElement: CustomStringConvertible {
//    override var description: String {
//        return "start = \(String(describing: start)), end = \(String(describing: end))"
//    }
//}
