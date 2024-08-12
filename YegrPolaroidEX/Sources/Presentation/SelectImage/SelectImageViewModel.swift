//
//  SelectImageViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import Foundation

final class SelectImageViewModel {
    var inputImageName = CustomObservable("")
    
    init() {
        inputImageName.bind { _ in
            self.selectedImage()
        }
    }
    
    private func selectedImage() {
        if !inputImageName.value.isEmpty {
            UserDefaultsManager.userTempProfileImageName = inputImageName.value
        }
    }
}
