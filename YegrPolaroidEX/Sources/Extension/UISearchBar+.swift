//
//  UISearchBar+.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/27/24.
//

import UIKit

extension UISearchBar {
    func setUI(placeholder: String) {
        showsCancelButton = true
        barTintColor = .pointDarkColor
        searchBarStyle = .minimal
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.pointDarkColor])
        searchTextField.leftView?.tintColor = .pointDarkColor
        searchTextField.textColor = .black
        keyboardType = .asciiCapable
        keyboardAppearance = .light
    }
}
