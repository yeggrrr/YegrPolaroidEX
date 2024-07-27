//
//  LikePhotoView.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/27/24.
//

import UIKit
import SnapKit

final class LikePhotoView: UIView, ViewRepresentable {
    private let filterbuttonView = UIView()
    let latestButton = UIButton(type: .system)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let noticeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configureUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        latestButton.layer.cornerRadius = latestButton.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubviews([filterbuttonView, collectionView, noticeLabel])
        filterbuttonView.addSubview(latestButton)
    }
    
    func setConstraints() {
        let safeArea = safeAreaLayoutGuide
  
        filterbuttonView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(40)
        }
        
        latestButton.snp.makeConstraints {
            $0.top.equalTo(filterbuttonView.snp.top)
            $0.trailing.equalTo(filterbuttonView.snp.trailing).offset(-5)
            $0.bottom.equalTo(filterbuttonView.snp.bottom).offset(-5)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filterbuttonView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.center.equalTo(collectionView.snp.center)
            $0.horizontalEdges.equalTo(collectionView.snp.horizontalEdges).inset(20)
        }
    }
    
    func configureUI() {
        // view
        backgroundColor = .white
        
        // latestButton
        var config = UIButton.Configuration.plain()
        config.title = "최신순"
        config.image = UIImage(named: "sort")
        config.baseForegroundColor = .pointDarkColor
        config.imagePadding = 5
        latestButton.configuration = config
        latestButton.layer.borderWidth = 1
        latestButton.layer.borderColor = UIColor.lightGray.cgColor
        
        // noticeLabel
        noticeLabel.text = "저장된 사진이 없습니다." // TODO: 좋아요 갯수 0개일 경우만 보이도록 설정
        noticeLabel.setUI(
            txtColor: .black,
            txtAlignment: .center,
            fontStyle: .systemFont(ofSize: 17, weight: .bold),
            numOfLines: 1)
    }
}



