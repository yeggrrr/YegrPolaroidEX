//
//  UIStackView+.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit

extension UIStackView {
    func setUI(SVAxis: NSLayoutConstraint.Axis, SVSpacing: CGFloat, SVAlignment: UIStackView.Alignment, SVDistribution: UIStackView.Distribution) {
        axis = SVAxis
        spacing = SVSpacing
        alignment = SVAlignment
        distribution = SVDistribution
    }
}
