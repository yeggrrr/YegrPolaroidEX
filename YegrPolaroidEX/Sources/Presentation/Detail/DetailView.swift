//
//  DetailView.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/25/24.
//

import UIKit
import SnapKit

class DetailView: UIView, ViewRepresentable {
    // MARK: UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let userInfoView = UIView()
    let profileImage = UIImageView()
    private let userInfoStackView = UIStackView()
    let userNameLabel = UILabel()
    let createdDateLabel = UILabel()
    let likeButton = UIButton()
    
    var posterImage = UIImageView()
    
    private let infoLabel = UILabel()
    
    private let photoDetailView = UIView()
    private let detailTitleStackView = UIStackView()
    private let sizeTitleLabel = UILabel()
    private let viewsTitleLabel = UILabel()
    private let downloadTitleLabel = UILabel()
    private let detailInfoStackView = UIStackView()
    let sizeInfoLabel = UILabel()
    let viewsInfoLabel = UILabel()
    let downloadInfoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configureUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubviews() {
        addSubviews([userInfoView, scrollView])
        scrollView.addSubview(contentView)
        userInfoView.addSubviews([profileImage, userInfoStackView, likeButton])
        userInfoStackView.addArrangedSubviews([userNameLabel, createdDateLabel])
        
        contentView.addSubviews([posterImage, infoLabel, photoDetailView])
        photoDetailView.addSubviews([detailTitleStackView, detailInfoStackView])
        detailTitleStackView.addArrangedSubviews([sizeTitleLabel, viewsTitleLabel, downloadTitleLabel])
        detailInfoStackView.addArrangedSubviews([sizeInfoLabel, viewsInfoLabel, downloadInfoLabel])
    }
    
    func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        let scrollViewFrame = scrollView.frameLayoutGuide
        let scrollViewContent = scrollView.contentLayoutGuide
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(userInfoView.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(safeArea)
        }
        
        contentView.snp.makeConstraints {
            $0.verticalEdges.equalTo(scrollViewContent.snp.verticalEdges)
            $0.horizontalEdges.equalTo(scrollViewFrame.snp.horizontalEdges)
        }
        
        userInfoView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(65)
        }
        
        profileImage.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(15)
            $0.width.equalTo(profileImage.snp.height)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
            $0.trailing.equalTo(likeButton.snp.leading).offset(-10)
            $0.verticalEdges.equalToSuperview().inset(15)
        }
        
        likeButton.snp.makeConstraints {
            $0.trailing.verticalEdges.equalToSuperview().inset(15)
            $0.width.equalTo(profileImage.snp.height)
        }
        
        posterImage.snp.makeConstraints {
            $0.top.equalTo(userInfoView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(40)
        }
        
        photoDetailView.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(10)
            $0.leading.equalTo(infoLabel.snp.trailing).offset(50)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(80)
        }
        
        detailTitleStackView.snp.makeConstraints {
            $0.verticalEdges.equalTo(photoDetailView.snp.verticalEdges)
            $0.leading.equalTo(photoDetailView.snp.leading)
            $0.width.equalTo(65)
        }
        
        detailInfoStackView.snp.makeConstraints {
            $0.verticalEdges.equalTo(photoDetailView.snp.verticalEdges)
            $0.leading.equalTo(detailTitleStackView.snp.trailing)
            $0.trailing.equalTo(photoDetailView.snp.trailing)
        }
        
    }
    
    func configureUI() {
        backgroundColor = .white
        
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        userInfoStackView.setUI(SVAxis: .vertical, SVSpacing: 0, SVAlignment: .fill, SVDistribution: .fillEqually)
        
        userNameLabel.setUI(txtColor: .black, txtAlignment: .left, fontStyle: .systemFont(ofSize: 13, weight: .regular), numOfLines: 1)
        createdDateLabel.setUI(txtColor: .black, txtAlignment: .left, fontStyle: .systemFont(ofSize: 11, weight: .bold), numOfLines: 1)
        
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        
        infoLabel.text = "정보"
        infoLabel.setUI(txtColor: .black, txtAlignment: .left, fontStyle: .systemFont(ofSize: 18, weight: .black), numOfLines: 1)
        
        detailTitleStackView.setUI(SVAxis: .vertical, SVSpacing: 0, SVAlignment: .leading, SVDistribution: .fillEqually)
        detailInfoStackView.setUI(SVAxis: .vertical, SVSpacing: 0, SVAlignment: .trailing, SVDistribution: .fillEqually)
        [sizeTitleLabel, viewsTitleLabel, downloadTitleLabel].forEach { lb in
            lb.setUI(txtColor: .black, txtAlignment: .left, fontStyle: .systemFont(ofSize: 14, weight: .bold), numOfLines: 1)
        }
        
        [sizeInfoLabel, viewsInfoLabel, downloadInfoLabel].forEach { lb in
            lb.setUI(txtColor: .darkGray, txtAlignment: .right, fontStyle: .systemFont(ofSize: 14, weight: .semibold), numOfLines: 1)
        }
        
        sizeTitleLabel.text = "크기"
        viewsTitleLabel.text = "조회수"
        downloadTitleLabel.text = "다운로드"
    }
}
