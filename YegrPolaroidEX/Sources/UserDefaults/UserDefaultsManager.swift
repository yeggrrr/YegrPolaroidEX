//
//  UserDefaultsManager.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import Foundation

struct UserDefaultsManager {
    enum UserDefaultsUserInfo: String {
        case isExistUser
        case name
        case profileImage
    }
    
    static var userTempProfileImageName: String?
    
    static func fetchisExistUser() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsUserInfo.isExistUser.rawValue)
    }
    
    static func save(value: Any, key: UserDefaultsUserInfo) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    static func fetchName() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.name.rawValue) ?? "-"
    }
    
    static func fetchProfileImage() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.profileImage.rawValue) ?? "-"
    }
}
