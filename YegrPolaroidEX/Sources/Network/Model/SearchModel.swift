//
//  SearchModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import Foundation

struct SearchModel: Decodable {
    let total: Int
    let totalPage: Int?
    let results: [Results]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPage = "total_page"
        case results
    }
        
    struct Results: Decodable {
        let id: String
        let createdAt: String
        let width: Int
        let height: Int
        let color: String
        let urls: Urls
        let likes: Int
        let user: User
        
        enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case width, height, color, urls, likes, user
        }
        
        struct Urls: Decodable {
            let raw: String
            let small: String
        }
        
        struct User: Decodable {
            let name: String
            let profileImage: ProfileImage
            
            enum CodingKeys: String, CodingKey {
                case name
                case profileImage = "profile_image"
            }
            
            struct ProfileImage: Decodable {
                let medium: String
            }
        }
    }
}
