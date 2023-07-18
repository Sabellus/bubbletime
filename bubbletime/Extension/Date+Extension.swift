//
//  Date+Extension.swift
//  bubbletime
//
//  Created by  savelii on 18.07.23.
//

import Foundation
extension Date {
    func localDate() -> String {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) else {return Date().description}

        return localDate.description
    }
}
