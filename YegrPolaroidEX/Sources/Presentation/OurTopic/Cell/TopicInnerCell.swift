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
    let containerView = UIView()
    let horizontalStackView = UIStackView()
    let starImage = UIImageView()
    let countLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        containerView.layer.cornerRadius = containerView.frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubviews() {
        contentView.addSubviews([posterImage, containerView])
        containerView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubviews([starImage, countLabel])
    }
    
    func setConstraints() {
        posterImage.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.leading.equalTo(posterImage.snp.leading).offset(10)
            $0.bottom.equalTo(posterImage.snp.bottom).offset(-10)
            $0.trailing.lessThanOrEqualTo(posterImage.snp.trailing).offset(-10)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.verticalEdges.equalTo(containerView.snp.verticalEdges)
            $0.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(10)
        }
        
        starImage.snp.makeConstraints {
            $0.leading.equalTo(horizontalStackView.snp.leading)
            $0.verticalEdges.equalTo(horizontalStackView.snp.verticalEdges).inset(5)
            $0.width.equalTo(starImage.snp.height)
        }
        
        countLabel.snp.makeConstraints {
            $0.trailing.equalTo(horizontalStackView.snp.trailing)
            $0.verticalEdges.equalTo(horizontalStackView.snp.verticalEdges).inset(5)
        }
    }
    
    func configureUI() {
        posterImage.layer.cornerRadius = 20
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        
        containerView.backgroundColor = .darkGray
        horizontalStackView.setUI(SVAxis: .horizontal, SVSpacing: 5, SVAlignment: .center, SVDistribution: .fill)
        
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .systemYellow
        
        countLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 11, weight: .regular), numOfLines: 1)
    }
}
