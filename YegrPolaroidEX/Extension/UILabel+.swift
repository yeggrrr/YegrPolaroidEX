//
//  UILabel+.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit

extension UILabel {
    func setUI(txtColor: UIColor, txtAlignment: NSTextAlignment, fontStyle: UIFont, numOfLines: Int) {
        textColor = txtColor
        textAlignment = txtAlignment
        font = fontStyle
        numberOfLines = numOfLines
    }
}
