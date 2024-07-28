//
//  LikePhotoViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/28/24.
//

import Foundation

final class LikePhotoViewModel {
    var inputLikeCountStateTrigger: Observable<Void?> = Observable(nil)
    var outputLikeCountStateTrigger: Observable<Void?> = Observable(nil)
    
    init() {
        inputLikeCountStateTrigger.bind { _ in
            self.outputLikeCountStateTrigger.value = ()
        }
    }
}
