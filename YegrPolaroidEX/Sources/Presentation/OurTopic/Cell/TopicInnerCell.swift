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
    let horizontalStackView = UIStackView()
    let starImage = UIImageView()
    let countLabel = UILabel()
    
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
        contentView.addSubviews([posterImage, horizontalStackView])
        horizontalStackView.addArrangedSubviews([starImage, countLabel])
    }
    
    func setConstraints() {
        posterImage.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.leading).offset(10)
            $0.bottom.equalTo(posterImage.snp.bottom).offset(-10)
            $0.trailing.lessThanOrEqualTo(posterImage.snp.trailing).offset(-10)
            $0.height.equalTo(25)
        }
        
        starImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(starImage.snp.height)
        }
        
        countLabel.snp.makeConstraints {
            $0.trailing.lessThanOrEqualToSuperview().offset(-10)
            $0.verticalEdges.equalToSuperview().inset(5)
        }
    }
    
    func configureUI() {
        posterImage.layer.cornerRadius = 20
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        
        horizontalStackView.setUI(SVAxis: .horizontal, SVSpacing: 5, SVAlignment: .leading, SVDistribution: .fill)
        horizontalStackView.backgroundColor = .darkGray
        horizontalStackView.layer.cornerRadius = 15
        
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .systemYellow
        
        countLabel.text = "1223"
        countLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 11, weight: .regular), numOfLines: 1)
    }
}
