//
//  APIRequest.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import Foundation
import Alamofire

enum TopicID: String {
    case goldHour = "golden-hour"
    case business = "business-work"
    case interior = "architecture-interior"
}

enum OrderBy {
    case latest
    case relevant
}

enum APIRequest {
    case topic(id: String)
    case search(query: String, page: Int, orderBy: OrderBy)
    case statistics(imageID: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: String {
        switch self {
        case .topic(let id):
            return baseURL + "topics/\(id)/photos?page=1&client_id=\(APIKey.AccessKey)"
        case .search(let query, let page, let orderBy):
            return baseURL + "search/photos?query=\(query)&page=\(page)&per_page=20&order_by=\(orderBy)&client_id=\(APIKey.AccessKey)"
        case .statistics(let imageID):
            return baseURL + "photos/\(imageID)/statistics?client_id=\(APIKey.AccessKey)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
