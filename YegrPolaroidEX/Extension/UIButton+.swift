//
//  UIButton+.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit

extension UIButton {
    func setPointUI(title: String, bgColor: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .heavy)
        backgroundColor = bgColor
        layer.cornerRadius = 20
    }
}
