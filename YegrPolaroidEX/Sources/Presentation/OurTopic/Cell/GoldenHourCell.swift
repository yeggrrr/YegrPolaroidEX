//
//  GoldenHourCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit
import Kingfisher

class GoldenHourCell: UICollectionViewCell {
    let goldenHourCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    var goldenHourData: [TopicData] = []
    
    weak var delegate: PushDelegate?
    
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
        contentView.addSubview(goldenHourCollectionView)
        goldenHourCollectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        goldenHourCollectionView.delegate = self
        goldenHourCollectionView.dataSource = self
        goldenHourCollectionView.register(TopicInnerCell.self, forCellWithReuseIdentifier: TopicInnerCell.id)
        goldenHourCollectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: UICollectionViewDataSource
extension GoldenHourCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goldenHourData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicInnerCell.id, for: indexPath) as? TopicInnerCell else { return UICollectionViewCell() }
        let imageUrl = goldenHourData[indexPath.item].urls.small
        if let image = URL(string: imageUrl) {
            cell.posterImage.kf.setImage(with: image, options: [.transition(.fade(1))])
        }
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
extension GoldenHourCell: UICollectionViewDelegate { 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushDetailView()
    }
}

protocol PushDelegate: AnyObject {
    func pushDetailView()
}
