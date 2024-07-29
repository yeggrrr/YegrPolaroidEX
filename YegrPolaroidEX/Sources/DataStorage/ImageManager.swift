//
//  ImageManager.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/28/24.
//

import UIKit

extension UIViewController {
    enum DirectoryType: String {
        case profile
        case poster
    }
    
    // MARK: Save Document
    func saveImageToDocumentDirectory(directoryType: DirectoryType, imageName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let filePath = documentDirectory.appendingPathComponent("yegrPolariod")
        
        if !FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error: \(error)")
            }
        }
        
        let imagePath = "\(directoryType.rawValue)\(imageName)"
        let imageURL = filePath.appendingPathComponent(imagePath)
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("SUCCESS - image deleted.")
            } catch {
                print("error: \(error)")
            }
        }
        
        do {
            try data.write(to: imageURL)
            print("SUCCESS - image saved.")
        } catch {
            print("FAILED - fail to save image.")
        }
    }
    
    // MARK: - Load Document
    func loadImageFromDocumentDirectory(directoryType: DirectoryType, imageName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let filePath = documentDirectory.appendingPathComponent("yegrPolariod")
        
        if !FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error: \(error)")
            }
        }
        
        let imagePath = "\(directoryType.rawValue)\(imageName)"
        let imageURL = filePath.appendingPathComponent(imagePath)
        return UIImage(contentsOfFile: imageURL.path)
    }
    
    // MARK: - Remove Document
    func deleteImageFromDucumentDirectory(directoryType: DirectoryType, imageName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let filePath = documentDirectory.appendingPathComponent("yegrPolariod")
        
        if !FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error: \(error)")
            }
        }
        
        let imagePath = "\(directoryType.rawValue)\(imageName)"
        let imageURL = filePath.appendingPathComponent(imagePath)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("REMOVE SUCCESS")
            } catch {
                print("error: \(error)")
            }
        }
    }
}
