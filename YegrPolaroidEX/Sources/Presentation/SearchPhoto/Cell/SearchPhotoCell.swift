//
//  SearchPhotoCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchPhotoCell: UICollectionViewCell, ViewRepresentable {
    // MARK: UI
    let posterImage = UIImageView()
    private let containerView = UIView()
    private let horizontalStackView = UIStackView()
    private let starImage = UIImageView()
    let countLabel = UILabel()
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
        
        containerView.layer.cornerRadius = containerView.frame.height / 2
        likeButton.layer.cornerRadius = likeButton.frame.height / 2
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Functions
    func addSubviews() {
        contentView.addSubviews([posterImage, containerView, likeButton])
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
            $0.trailing.lessThanOrEqualTo(likeButton.snp.leading).offset(-10)
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
        
        likeButton.snp.makeConstraints {
            $0.trailing.equalTo(posterImage.snp.trailing).offset(-10)
            $0.bottom.equalTo(posterImage.snp.bottom).offset(-10)
            $0.width.height.equalTo(30)
        }
    }
    
    func configureUI() {
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        
        containerView.backgroundColor = .darkGray
        horizontalStackView.setUI(
            SVAxis: .horizontal,
            SVSpacing: 5,
            SVAlignment: .center,
            SVDistribution: .fill)
        
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .systemYellow
        
        countLabel.setUI(
            txtColor: .white,
            txtAlignment: .center,
            fontStyle: .systemFont(ofSize: 11, weight: .regular),
            numOfLines: 1)
    }
    
    func configureCell(item: SearchModel.Results) {
        let imageURL = URL(string: item.urls.small)
        posterImage.kf.setImage(with: imageURL)
        countLabel.text = item.likes.formatted()
        likeButton.backgroundColor = .white
        likeButton.setImage(
            UIImage(named: "likeCircleInactive")?.withTintColor(.incompleteColor, renderingMode: .alwaysOriginal),
            for: .normal)
        likeButton.setImage(
            UIImage(named: "likeCircle")?.withTintColor(.pointDarkColor, renderingMode: .alwaysOriginal),
            for: .selected)
    }
}
