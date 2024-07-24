//
//  TopicModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import Foundation

struct TopicData: Decodable {
    let id: String // 사진 ID
    let createdAt: String // 사진 게시일
    let width: Int // 해상도
    let height: Int // 해상도
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
        let raw: String // 원본 이미지
        let small: String // 작은 이미지
    }
    
    struct User: Decodable {
        let name: String // 사진 작가
        let profileImage: ProfileImage
        
        enum CodingKeys: String, CodingKey {
            case name
            case profileImage = "profile_image"
        }
        
        struct ProfileImage: Decodable {
            let medium: String // 사진 작가 프로필 이미지
        }
    }
}
