//
//  SearchPhotoView.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/26/24.
//

import UIKit
import SnapKit

class SearchPhotoView: UIView, ViewRepresentable {
    let filterbuttonView = UIView()
    let latestButton = UIButton(type: .system)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
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
        addSubviews([filterbuttonView, collectionView])
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
    }
    
    func configureUI() {
        // view
        backgroundColor = .white
        collectionView.backgroundColor = .systemGray
        
        var config = UIButton.Configuration.plain()
        config.title = "최신순"
        config.image = UIImage(named: "sort")
        latestButton.configuration = config
        latestButton.layer.borderWidth = 1
        latestButton.layer.borderColor = UIColor.lightGray.cgColor
    }
}

