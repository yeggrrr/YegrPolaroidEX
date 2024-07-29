//
//  LikePhotoViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/28/24.
//

import Foundation

final class LikePhotoViewModel {
    // input
    var inputLikeCountStateTrigger: Observable<Void?> = Observable(nil)
    // output
    var outputLikeCountStateTrigger: Observable<Void?> = Observable(nil)
    
    init() {
        inputLikeCountStateTrigger.bind { _ in
            self.outputLikeCountStateTrigger.value = ()
        }
    }
}
