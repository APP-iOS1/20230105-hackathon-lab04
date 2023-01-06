//
//  Date+.swift
//  lab04-hackathon
//
//  Created by 서광현 on 2023/01/06.
//

import Foundation

extension Date {
    var dayFormmat: String {
        let date = abs(self.timeIntervalSince(.now) / 3600.0)
        switch date {
        case 0..<1:
            return "오늘"
        case 1..<7:
            return String(format: "%.f", date) + "일전"
        case 7..<365:
            return String(format: "%.f", date / 7.0) + "주전"
        default:
            return String(format: "%.f", date / 365.0) + "년전"
        }
    }
}
