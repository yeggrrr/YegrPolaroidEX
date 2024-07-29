//
//  DateFormatter+.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import Foundation

extension DateFormatter {
    static let containLettersDateFormatter: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = "yyyy년 MM월 dd일"
        return dateFormat
    }()
    
    static let stringToDateFormatter: ISO8601DateFormatter = {
        let dateFormat = ISO8601DateFormatter()
        return dateFormat
    }()
    
    static func dateToContainLetter(dateString: String) -> String {
        guard let date = DateFormatter.stringToDateFormatter.date(from: dateString) else { return "-" }
        return DateFormatter.containLettersDateFormatter.string(from: date)
    }
}


