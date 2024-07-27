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
    
    func setMbtiUI(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.incompleteColor, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        backgroundColor = .clear
        layer.cornerRadius = 27.5
        layer.borderWidth = 1
        layer.borderColor = UIColor.incompleteColor.cgColor
    }
    
    func topProfileUI(imageName: String) {
        setImage(UIImage(named: imageName), for: .normal)
        layer.borderColor = UIColor.customPoint.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        clipsToBounds = true
    }
}
