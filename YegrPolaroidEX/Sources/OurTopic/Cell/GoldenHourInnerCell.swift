//
//  GoldenHourInnerCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit

final class GoldenHourInnerCell: UICollectionViewCell, ViewRepresentable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.backgroundColor = .systemBrown
    }
    
    func addSubviews() {
        print("")
    }
    
    func setConstraints() {
        print("")
    }
}
