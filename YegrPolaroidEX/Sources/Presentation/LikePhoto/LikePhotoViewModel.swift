//
//  LikePhotoViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/28/24.
//

import Foundation

final class LikePhotoViewModel {
    // input
    var inputLikeCountStateTrigger: CustomObservable<Void?> = CustomObservable(nil)
    // output
    var outputLikeCountStateTrigger: CustomObservable<Void?> = CustomObservable(nil)
    
    init() {
        inputLikeCountStateTrigger.bind { _ in
            self.outputLikeCountStateTrigger.value = ()
        }
    }
}
