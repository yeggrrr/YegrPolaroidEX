//
//  PhotoRepository.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/27/24.
//

import RealmSwift

final class PhotoRepository: PhotoRepositoryType {
    static let shared = PhotoRepository()
    
    private let realm = try! Realm()
    
    private init() { }
    
    var count: Int {
        return fetch().count
    }
    
    func findFilePath() {
        print(realm.configuration.fileURL ?? "-")
    }
    
    func fetch() -> [PhotoRealm] {
        return Array(realm.objects(PhotoRealm.self))
    }
    
    func add(item: PhotoRealm) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Failed to add: \(error)")
        }
    }
    
    func update(item: PhotoRealm) {
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print("Failed to update: \(error)")
        }
    }
    
    func delete(item: PhotoRealm) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Failed to delete: \(error)")
        }
    }
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Failed to deleteAll: \(error)")
        }
    }
}

protocol PhotoRepositoryType {
    var count: Int { get }
    func fetch() -> [PhotoRealm]
    func add(item: PhotoRealm)
    func update(item: PhotoRealm)
    func delete(item: PhotoRealm)
}
