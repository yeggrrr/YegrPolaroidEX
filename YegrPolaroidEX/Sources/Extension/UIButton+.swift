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
        layer.borderColor = UIColor.customPointColor.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        clipsToBounds = true
    }
}

extension UIButton {
    // 이미지 상태별 배경색상 변경
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
