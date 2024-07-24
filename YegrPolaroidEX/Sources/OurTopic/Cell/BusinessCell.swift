//
//  BusinessCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit

class BusinessCell: UICollectionViewCell {
    let businessCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        // contentView
        contentView.backgroundColor = .white
        
        // collectioView
        contentView.addSubview(businessCollectionView)
        businessCollectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        businessCollectionView.delegate = self
        businessCollectionView.dataSource = self
        businessCollectionView.register(BusinessInnerCell.self, forCellWithReuseIdentifier: BusinessInnerCell.id)
        businessCollectionView.backgroundColor = .systemCyan
        businessCollectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: UICollectionViewDataSource
extension BusinessCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // 임시
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusinessInnerCell.id, for: indexPath) as? BusinessInnerCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension BusinessCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        let height = collectionView.frame.height
        let size = CGSize(width: width, height: height)
        return size
    }
}

// MARK: UICollectionViewDelegate
extension BusinessCell: UICollectionViewDelegate { }
