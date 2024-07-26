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
    case search(query: String, page: Int)
    case statistics(imageID: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: String {
        switch self {
        case .topic(id: let id):
            return baseURL + "topics/\(id)/photos?page=1&client_id=\(APIKey.AccessKey)"
        case .search(query: let query, page: let page):
            return baseURL + "search/photos?query=\(query)&page=1&per_page=\(page)&order_by=latest&color=yellow&client_id=\(APIKey.AccessKey)"
        case .statistics(imageID: let imageID):
            return baseURL + "photos/\(imageID)/statistics?client_id=\(APIKey.AccessKey)"
        }
    }
    
    var params: Parameters {
        switch self {
        case .topic(let id):
            return ["" : ""]
        case .search(let query, let page):
            return ["lang" : "ko"]
        case .statistics(let imageID):
            return ["" : ""]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
