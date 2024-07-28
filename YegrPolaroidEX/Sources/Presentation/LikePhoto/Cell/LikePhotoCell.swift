//
//  LikePhotoCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/28/24.
//

import UIKit
import SnapKit

class LikePhotoCell: UICollectionViewCell, ViewRepresentable {
    let posterImage = UIImageView()
    let likeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubviews() {
        contentView.addSubviews([posterImage, likeButton])
    }
    
    func setConstraints() {
        posterImage.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
        
        likeButton.snp.makeConstraints {
            $0.bottom.equalTo(posterImage.snp.bottom).offset(-15)
            $0.trailing.equalTo(posterImage.snp.trailing).offset(-15)
            $0.width.height.equalTo(30)
        }
    }
    
    func configureUI() {
        likeButton.isSelected = true
        
        likeButton.setImage(
            UIImage(named: "likeCircleInactive")?.withTintColor(.white, renderingMode: .alwaysOriginal),
            for: .normal)
        likeButton.setImage(
            UIImage(named: "likeCircle")?.withTintColor(.pointDarkColor, renderingMode: .alwaysOriginal),
            for: .selected)
    }
}
