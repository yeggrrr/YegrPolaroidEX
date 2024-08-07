//
//  OnBoadingViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 8/7/24.
//

import Foundation
import RxSwift
import RxCocoa

class OnBoadingViewModel {
    let logoText = Observable.just("HELLO ◡̎\nMY MEMORIES")
    let posterImageName = Observable.just("launchPosterImage")
    let nameText = Observable.just("김예진")
    let startButtonText = Observable.just("시작하기")
    
    struct Input {
        let startButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let logoText: Observable<String>
        let posterImageName: Observable<String>
        let nameText: Observable<String>
        let startButtonText: Observable<String>
        let startButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(logoText: logoText,
                      posterImageName: posterImageName,
                      nameText: nameText,
                      startButtonText: startButtonText,
                      startButtonTap: input.startButtonTap)
    }
}
