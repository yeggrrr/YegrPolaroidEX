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
}
