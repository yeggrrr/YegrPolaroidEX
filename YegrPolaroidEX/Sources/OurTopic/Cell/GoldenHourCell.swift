//
//  GoldenHourCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit

class GoldenHourCell: UICollectionViewCell {
    let GoldenHourCollectionView: UICollectionView = {
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
        contentView.addSubview(GoldenHourCollectionView)
        GoldenHourCollectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        GoldenHourCollectionView.delegate = self
        GoldenHourCollectionView.dataSource = self
        GoldenHourCollectionView.register(GoldenHourInnerCell.self, forCellWithReuseIdentifier: GoldenHourInnerCell.id)
        GoldenHourCollectionView.backgroundColor = .systemCyan
        GoldenHourCollectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: UICollectionViewDataSource
extension GoldenHourCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // 임시
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoldenHourInnerCell.id, for: indexPath) as? GoldenHourInnerCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension GoldenHourCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        let height = collectionView.frame.height
        let size = CGSize(width: width, height: height)
        return size
    }
}

// MARK: UICollectionViewDelegate
extension GoldenHourCell: UICollectionViewDelegate { }
