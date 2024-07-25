//
//  SelectImageViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import Foundation

class SelectImageViewModel {
    var inputImageName = Observable("")
    
    init() {
        inputImageName.bind { _ in
            self.selectedImage()
        }
    }
    
    func selectedImage() {
        if !inputImageName.value.isEmpty {
            UserDefaultsManager.userTempProfileImageName = inputImageName.value
        }
    }
}
