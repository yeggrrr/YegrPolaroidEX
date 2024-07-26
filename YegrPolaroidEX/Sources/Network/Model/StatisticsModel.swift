//
//  StatisticsModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import Foundation

struct StatisticsData: Decodable {
    let id: String // 사진 ID
    let downloads: Downloads
    let views: Views
    
    struct Downloads: Decodable {
        let total: Int // 다운로드 수
    }
    
    struct Views: Decodable {
        let total: Int // 조회수
    }
}
