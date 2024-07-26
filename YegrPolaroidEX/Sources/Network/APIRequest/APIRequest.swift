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

enum APIRequest {
    case topic(id: String)
    case search(query: String)
    case Statistics(imageID: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: String {
        switch self {
        case .topic(id: let id):
            return baseURL + "topics/\(id)/photos?page=1&client_id=\(APIKey.AccessKey)"
        case .search(query: let query):
            return baseURL + "search/photos?query=\(query)&page=1&per_page=20&order_by=latest&color=yellow&client_id=\(APIKey.AccessKey)"
        case .Statistics(imageID: let imageID):
            return baseURL + "photos/\(imageID)/statistics?client_id=\(APIKey.AccessKey)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
