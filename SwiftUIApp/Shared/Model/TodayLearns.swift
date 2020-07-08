//
//  TodayLearns.swift
//  iOS
//
//  Created by israel.berezin on 07/07/2020.
//

// To parse the JSON, add this file to your project and do:
//
//   let todayLearns = try TodayLearns(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.todayLearnsTask(with: url) { todayLearns, response, error in
//     if let todayLearns = todayLearns {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - TodayLearns
class TodayLearns: Codable, Loopable {

    var date, timezone: String?
    var calendarItems: [CalendarItem]?

    enum CodingKeys: String, CodingKey {
        case date, timezone
        case calendarItems = "calendar_items"
    }

    init(date: String?, timezone: String?, calendarItems: [CalendarItem]?) {
        self.date = date
        self.timezone = timezone
        self.calendarItems = calendarItems
    }
}

// MARK: TodayLearns convenience initializers and mutators

extension TodayLearns {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TodayLearns.self, from: data)
        self.init(date: me.date, timezone: me.timezone, calendarItems: me.calendarItems)
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
        date: String?? = nil,
        timezone: String?? = nil,
        calendarItems: [CalendarItem]?? = nil
    ) -> TodayLearns {
        return TodayLearns(
            date: date ?? self.date,
            timezone: timezone ?? self.timezone,
            calendarItems: calendarItems ?? self.calendarItems
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.calendarItemTask(with: url) { calendarItem, response, error in
//     if let calendarItem = calendarItem {
//       ...
//     }
//   }
//   task.resume()

// MARK: - CalendarItem
class CalendarItem: Codable, Loopable, Identifiable {
    let id = UUID()
    var title, displayValue: DisplayValue?
    var url, ref: String?
    var order: Int?
    var category: String?

    init(title: DisplayValue?, displayValue: DisplayValue?, url: String?, ref: String?, order: Int?, category: String?) {
        self.title = title
        self.displayValue = displayValue
        self.url = url
        self.ref = ref
        self.order = order
        self.category = category
    }
}

// MARK: CalendarItem convenience initializers and mutators

extension CalendarItem {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CalendarItem.self, from: data)
        self.init(title: me.title, displayValue: me.displayValue, url: me.url, ref: me.ref, order: me.order, category: me.category)
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
        title: DisplayValue?? = nil,
        displayValue: DisplayValue?? = nil,
        url: String?? = nil,
        ref: String?? = nil,
        order: Int?? = nil,
        category: String?? = nil
    ) -> CalendarItem {
        return CalendarItem(
            title: title ?? self.title,
            displayValue: displayValue ?? self.displayValue,
            url: url ?? self.url,
            ref: ref ?? self.ref,
            order: order ?? self.order,
            category: category ?? self.category
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.displayValueTask(with: url) { displayValue, response, error in
//     if let displayValue = displayValue {
//       ...
//     }
//   }
//   task.resume()

// MARK: - DisplayValue
class DisplayValue: Codable, Loopable  {
    var en, he: String?

    init(en: String?, he: String?) {
        self.en = en
        self.he = he
    }
}

// MARK: DisplayValue convenience initializers and mutators

extension DisplayValue {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DisplayValue.self, from: data)
        self.init(en: me.en, he: me.he)
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
        en: String?? = nil,
        he: String?? = nil
    ) -> DisplayValue {
        return DisplayValue(
            en: en ?? self.en,
            he: he ?? self.he
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func todayLearnsTask(with url: URL, completionHandler: @escaping (TodayLearns?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}



/*
 var date, timezone: String?
 var calendarItems: [CalendarItem]?

 */
extension TodayLearns: CustomStringConvertible {
    var description: String {
        return "date = \(String(describing: date)), timezone = \(String(describing: timezone)) \nCalendarItem\n\(String(describing: calendarItems))\n\n)"
    }
}

/*
 
 var title, displayValue: DisplayValue?
 var url, ref: String?
 var order: Int?
 var category: String?

 */
extension CalendarItem: CustomStringConvertible {
    var description: String {
        return "Title = \(String(describing: title)), displayValue = \(String(describing: displayValue)), url = \(String(describing: url)), ref = \(String(describing: ref)), order = \(String(describing: order)), category = \(String(describing: category)))\n"
    }
}


/*
 class DisplayValue: Codable {
     var en, he: String?

 */
extension DisplayValue: CustomStringConvertible {
    var description: String {
        return "en = \(String(describing: en)), he = \(String(describing: he)))"
    }
}

// let newString = aString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)

