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
        barTintColor = .systemPurple
        searchBarStyle = .minimal
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemPurple])
        searchTextField.leftView?.tintColor = .systemPurple
        searchTextField.textColor = .black
        keyboardType = .default
        keyboardAppearance = .light
    }
}
