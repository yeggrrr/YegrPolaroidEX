//
//  LikePhotoCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/28/24.
//

import UIKit
import SnapKit

class LikePhotoCell: UICollectionViewCell, ViewRepresentable {
    // MARK: UI
    let posterImage = UIImageView()
    let likeButton = UIButton()
    
    // MARK: View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configureUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Functions
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
        
        likeButton.backgroundColor = .white
        likeButton.setImage(
            UIImage(named: "likeCircleInactive")?.withTintColor(.incompleteColor, renderingMode: .alwaysOriginal),
            for: .normal)
        likeButton.setImage(
            UIImage(named: "likeCircle")?.withTintColor(.pointDarkColor, renderingMode: .alwaysOriginal),
            for: .selected)
    }
}
