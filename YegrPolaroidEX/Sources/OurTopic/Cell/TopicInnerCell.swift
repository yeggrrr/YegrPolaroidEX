//
//  TopicInnerCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit

final class TopicInnerCell: UICollectionViewCell, ViewRepresentable {
    let posterImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(posterImage)
    }
    
    func setConstraints() {
        posterImage.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        posterImage.layer.cornerRadius = 20
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
    }
}
