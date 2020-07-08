//
//  TodayTimes.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 07/07/2020.
//
// To parse the JSON, add this file to your project and do:
//
//   let todayTimes = try TodayTimes(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.todayTimesTask(with: url) { todayTimes, response, error in
//     if let todayTimes = todayTimes {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - TodayTimes
class TodayTimes: Codable, Loopable  {
    var currentTime, engDateString, hebDateString, dayOfWeek: String?
    var zmanim: Zmanim?
    var dafYomi: DafYomi?
    var specialShabbos: Bool?
    var parshaShabbos, candleLightingShabbos: String?

    enum CodingKeys: String, CodingKey {
        case currentTime, engDateString, hebDateString, dayOfWeek, zmanim, dafYomi, specialShabbos
        case parshaShabbos = "parsha_shabbos"
        case candleLightingShabbos = "candle_lighting_shabbos"
    }

    init(currentTime: String?, engDateString: String?, hebDateString: String?, dayOfWeek: String?, zmanim: Zmanim?, dafYomi: DafYomi?, specialShabbos: Bool?, parshaShabbos: String?, candleLightingShabbos: String?) {
        self.currentTime = currentTime
        self.engDateString = engDateString
        self.hebDateString = hebDateString
        self.dayOfWeek = dayOfWeek
        self.zmanim = zmanim
        self.dafYomi = dafYomi
        self.specialShabbos = specialShabbos
        self.parshaShabbos = parshaShabbos
        self.candleLightingShabbos = candleLightingShabbos
    }
}

// MARK: TodayTimes convenience initializers and mutators

extension TodayTimes {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TodayTimes.self, from: data)
        self.init(currentTime: me.currentTime, engDateString: me.engDateString, hebDateString: me.hebDateString, dayOfWeek: me.dayOfWeek, zmanim: me.zmanim, dafYomi: me.dafYomi, specialShabbos: me.specialShabbos, parshaShabbos: me.parshaShabbos, candleLightingShabbos: me.candleLightingShabbos)
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
        currentTime: String?? = nil,
        engDateString: String?? = nil,
        hebDateString: String?? = nil,
        dayOfWeek: String?? = nil,
        zmanim: Zmanim?? = nil,
        dafYomi: DafYomi?? = nil,
        specialShabbos: Bool?? = nil,
        parshaShabbos: String?? = nil,
        candleLightingShabbos: String?? = nil
    ) -> TodayTimes {
        return TodayTimes(
            currentTime: currentTime ?? self.currentTime,
            engDateString: engDateString ?? self.engDateString,
            hebDateString: hebDateString ?? self.hebDateString,
            dayOfWeek: dayOfWeek ?? self.dayOfWeek,
            zmanim: zmanim ?? self.zmanim,
            dafYomi: dafYomi ?? self.dafYomi,
            specialShabbos: specialShabbos ?? self.specialShabbos,
            parshaShabbos: parshaShabbos ?? self.parshaShabbos,
            candleLightingShabbos: candleLightingShabbos ?? self.candleLightingShabbos
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
//   let task = URLSession.shared.dafYomiTask(with: url) { dafYomi, response, error in
//     if let dafYomi = dafYomi {
//       ...
//     }
//   }
//   task.resume()

// MARK: - DafYomi
class DafYomi: Codable, Loopable {
    var masechta, daf: String?

    init(masechta: String?, daf: String?) {
        self.masechta = masechta
        self.daf = daf
    }
}

// MARK: DafYomi convenience initializers and mutators

extension DafYomi {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DafYomi.self, from: data)
        self.init(masechta: me.masechta, daf: me.daf)
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
        masechta: String?? = nil,
        daf: String?? = nil
    ) -> DafYomi {
        return DafYomi(
            masechta: masechta ?? self.masechta,
            daf: daf ?? self.daf
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
//   let task = URLSession.shared.zmanimTask(with: url) { zmanim, response, error in
//     if let zmanim = zmanim {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Zmanim
class Zmanim: Codable, Loopable {
    var sunrise, sofZmanTefilaGra, talisMa, tzeis595_Degrees: String?
    var chatzos, minchaKetanaGra, plagMinchaMa, sofZmanShemaGra: String?
    var sofZmanTefilaMa, tzeis42_Minutes, tzeis72_Minutes, tzeis850_Degrees: String?
    var sunset, sofZmanShemaMa, alosMa, minchaGedolaMa: String?

    enum CodingKeys: String, CodingKey {
        case sunrise
        case sofZmanTefilaGra = "sof_zman_tefila_gra"
        case talisMa = "talis_ma"
        case tzeis595_Degrees = "tzeis_595_degrees"
        case chatzos
        case minchaKetanaGra = "mincha_ketana_gra"
        case plagMinchaMa = "plag_mincha_ma"
        case sofZmanShemaGra = "sof_zman_shema_gra"
        case sofZmanTefilaMa = "sof_zman_tefila_ma"
        case tzeis42_Minutes = "tzeis_42_minutes"
        case tzeis72_Minutes = "tzeis_72_minutes"
        case tzeis850_Degrees = "tzeis_850_degrees"
        case sunset
        case sofZmanShemaMa = "sof_zman_shema_ma"
        case alosMa = "alos_ma"
        case minchaGedolaMa = "mincha_gedola_ma"
    }

    init(sunrise: String?, sofZmanTefilaGra: String?, talisMa: String?, tzeis595_Degrees: String?, chatzos: String?, minchaKetanaGra: String?, plagMinchaMa: String?, sofZmanShemaGra: String?, sofZmanTefilaMa: String?, tzeis42_Minutes: String?, tzeis72_Minutes: String?, tzeis850_Degrees: String?, sunset: String?, sofZmanShemaMa: String?, alosMa: String?, minchaGedolaMa: String?) {
        self.sunrise = sunrise
        self.sofZmanTefilaGra = sofZmanTefilaGra
        self.talisMa = talisMa
        self.tzeis595_Degrees = tzeis595_Degrees
        self.chatzos = chatzos
        self.minchaKetanaGra = minchaKetanaGra
        self.plagMinchaMa = plagMinchaMa
        self.sofZmanShemaGra = sofZmanShemaGra
        self.sofZmanTefilaMa = sofZmanTefilaMa
        self.tzeis42_Minutes = tzeis42_Minutes
        self.tzeis72_Minutes = tzeis72_Minutes
        self.tzeis850_Degrees = tzeis850_Degrees
        self.sunset = sunset
        self.sofZmanShemaMa = sofZmanShemaMa
        self.alosMa = alosMa
        self.minchaGedolaMa = minchaGedolaMa
    }
}

// MARK: Zmanim convenience initializers and mutators

extension Zmanim {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Zmanim.self, from: data)
        self.init(sunrise: me.sunrise, sofZmanTefilaGra: me.sofZmanTefilaGra, talisMa: me.talisMa, tzeis595_Degrees: me.tzeis595_Degrees, chatzos: me.chatzos, minchaKetanaGra: me.minchaKetanaGra, plagMinchaMa: me.plagMinchaMa, sofZmanShemaGra: me.sofZmanShemaGra, sofZmanTefilaMa: me.sofZmanTefilaMa, tzeis42_Minutes: me.tzeis42_Minutes, tzeis72_Minutes: me.tzeis72_Minutes, tzeis850_Degrees: me.tzeis850_Degrees, sunset: me.sunset, sofZmanShemaMa: me.sofZmanShemaMa, alosMa: me.alosMa, minchaGedolaMa: me.minchaGedolaMa)
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
        sunrise: String?? = nil,
        sofZmanTefilaGra: String?? = nil,
        talisMa: String?? = nil,
        tzeis595_Degrees: String?? = nil,
        chatzos: String?? = nil,
        minchaKetanaGra: String?? = nil,
        plagMinchaMa: String?? = nil,
        sofZmanShemaGra: String?? = nil,
        sofZmanTefilaMa: String?? = nil,
        tzeis42_Minutes: String?? = nil,
        tzeis72_Minutes: String?? = nil,
        tzeis850_Degrees: String?? = nil,
        sunset: String?? = nil,
        sofZmanShemaMa: String?? = nil,
        alosMa: String?? = nil,
        minchaGedolaMa: String?? = nil
    ) -> Zmanim {
        return Zmanim(
            sunrise: sunrise ?? self.sunrise,
            sofZmanTefilaGra: sofZmanTefilaGra ?? self.sofZmanTefilaGra,
            talisMa: talisMa ?? self.talisMa,
            tzeis595_Degrees: tzeis595_Degrees ?? self.tzeis595_Degrees,
            chatzos: chatzos ?? self.chatzos,
            minchaKetanaGra: minchaKetanaGra ?? self.minchaKetanaGra,
            plagMinchaMa: plagMinchaMa ?? self.plagMinchaMa,
            sofZmanShemaGra: sofZmanShemaGra ?? self.sofZmanShemaGra,
            sofZmanTefilaMa: sofZmanTefilaMa ?? self.sofZmanTefilaMa,
            tzeis42_Minutes: tzeis42_Minutes ?? self.tzeis42_Minutes,
            tzeis72_Minutes: tzeis72_Minutes ?? self.tzeis72_Minutes,
            tzeis850_Degrees: tzeis850_Degrees ?? self.tzeis850_Degrees,
            sunset: sunset ?? self.sunset,
            sofZmanShemaMa: sofZmanShemaMa ?? self.sofZmanShemaMa,
            alosMa: alosMa ?? self.alosMa,
            minchaGedolaMa: minchaGedolaMa ?? self.minchaGedolaMa
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//// MARK: - Helper functions for creating encoders and decoders
//
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

    func todayTimesTask(with url: URL, completionHandler: @escaping (TodayTimes?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

//     var parshaShabbos, candleLightingShabbos: String?

extension TodayTimes: CustomStringConvertible {
    var description: String {
        return "hebDateString = \(String(describing: hebDateString)), parshaShabbos = \(String(describing: parshaShabbos)), candleLightingShabbos = \(String(describing: candleLightingShabbos))\nZmanim\n\(String(describing: zmanim))\nDafYomi\n\(String(describing: dafYomi))\n\n)"
    }
}

/*
 var sunrise, sofZmanTefilaGra, talisMa, tzeis595_Degrees: String?
 var chatzos, minchaKetanaGra, plagMinchaMa, sofZmanShemaGra: String?
 var sofZmanTefilaMa, tzeis42_Minutes, tzeis72_Minutes, tzeis850_Degrees: String?
 var sunset, sofZmanShemaMa, alosMa, minchaGedolaMa: String?

 */
extension Zmanim: CustomStringConvertible {
    var description: String {
        return "sunrise = \(String(describing: sunrise)) ,sofZmanTefilaGra = \(String(describing: sofZmanTefilaGra)), talisMa = \(String(describing: talisMa)), tzeis595_Degrees = \(String(describing: tzeis595_Degrees)), chatzos = \(String(describing: chatzos)), minchaKetanaGra = \(String(describing: minchaKetanaGra)), plagMinchaMa = \(String(describing: plagMinchaMa)), sofZmanShemaGra = \(String(describing: sofZmanShemaGra)), sofZmanTefilaMa = \(String(describing: sofZmanTefilaMa)), tzeis42_Minutes = \(String(describing: tzeis42_Minutes)), tzeis72_Minutes = \(String(describing: tzeis72_Minutes)), tzeis850_Degrees = \(String(describing: tzeis850_Degrees)), sunset = \(String(describing: sunset)), sofZmanShemaMa = \(String(describing: sofZmanShemaMa)), alosMa = \(String(describing: alosMa)), minchaGedolaMa = \(String(describing: minchaGedolaMa))"
    }
}

//    var masechta, daf: String?

extension DafYomi: CustomStringConvertible {
    var description: String {
        return "masechta = \(String(describing: masechta)), daf = \(String(describing: daf))"
    }
}



protocol Loopable {
    func allProperties() throws -> [[String: Any]]
}

extension Loopable {
    func allProperties() throws -> [[String: Any]] {

        var result: [[String: Any]] = [[:]]

        let mirror = Mirror(reflecting: self)

        // Optional check to make sure we're iterating over a struct or class
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            throw NSError()
        }

        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }
            result.append([property:value])
//            result[property] = value
        }

        return result
    }
}
