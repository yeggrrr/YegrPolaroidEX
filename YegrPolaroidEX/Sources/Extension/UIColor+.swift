//
//  UIColor+.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit

extension UIColor {
    static var pointColor: UIColor {
        return UIColor(named: "CustomPointColor") ?? .systemPurple
    }
    
    static var incompleteColor: UIColor {
        return .systemGray2
    }
}
