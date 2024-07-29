//
//  StatisticsModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import Foundation

struct StatisticsData: Decodable {
    let id: String
    let downloads: Downloads
    let views: Views
    
    struct Downloads: Decodable {
        let total: Int
    }
    
    struct Views: Decodable {
        let total: Int
    }
}
