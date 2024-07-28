//
//  PhotoRealm.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/27/24.
//


import Foundation
import RealmSwift

class PhotoRealm: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var imageID: String
    @Persisted var profileImage: String
    @Persisted var userName: String
    @Persisted var createdDate: String
    @Persisted var posterImage: String
    @Persisted var sizeInfo: String
    @Persisted var viewsInfo: Int
    @Persisted var downloadInfo: Int
    @Persisted var savedTheDate: Date
    
    convenience init(imageID: String, profileImage: String, userName: String, createdDate: String, posterImage: String, sizeInfo: String, viewsInfo: Int, downloadInfo: Int, savedTheDate: Date) {
        self.init()
        self.imageID = imageID
        self.profileImage = profileImage
        self.userName = userName
        self.createdDate = createdDate
        self.posterImage = posterImage
        self.sizeInfo = sizeInfo
        self.viewsInfo = viewsInfo
        self.downloadInfo = downloadInfo
        self.savedTheDate = savedTheDate
    }
}
