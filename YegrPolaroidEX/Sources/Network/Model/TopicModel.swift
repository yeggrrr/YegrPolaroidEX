//
//  TopicModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import Foundation

struct TopicData: Decodable {
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
        case width
        case height
        case color
        case urls
        case likes
        case user
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
