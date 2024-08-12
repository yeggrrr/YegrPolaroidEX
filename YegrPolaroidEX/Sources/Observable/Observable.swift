//
//  Observable.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import Foundation

class CustomObservable<T> {
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}
