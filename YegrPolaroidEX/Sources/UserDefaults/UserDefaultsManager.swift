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
        case sourceOfEnergy // E, I
        case processingOfInfo // S, N
        case decisionMaking // T, F
        case needForStructure // J, P
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
    
    static func fetchSourceOfEnergy() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.sourceOfEnergy.rawValue) ?? "-"
    }
    
    static func fetchProcessingOfInfo() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.processingOfInfo.rawValue) ?? "-"
    }
    
    static func fetchDecisionMaking() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.decisionMaking.rawValue) ?? "-"
    }
    
    static func fetchNeedForStructure() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.needForStructure.rawValue) ?? "-"
    }
}
