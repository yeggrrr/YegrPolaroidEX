//
//  BusinessCell.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit
import Kingfisher

final class BusinessCell: UICollectionViewCell {
    // MARK: UI
    let businessCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    // MARK: Properties
    var businessData: [TopicData] = []
    weak var delegate: PushDelegate?
    
    // MARK: View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Functions
    private func configureUI() {
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
        businessCollectionView.register(TopicInnerCell.self, forCellWithReuseIdentifier: TopicInnerCell.id)
        businessCollectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: UICollectionViewDataSource
extension BusinessCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return businessData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicInnerCell.id, for: indexPath) as? TopicInnerCell else { return UICollectionViewCell() }
        let item = businessData[indexPath.item]
        if let image = URL(string: item.urls.small) {
            cell.posterImage.kf.setImage(with: image, options: [.transition(.fade(1))])
        }
        
        cell.countLabel.text = "\(item.likes)"
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
extension BusinessCell: UICollectionViewDelegate { 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushDetailView(sectionType: .business, index: indexPath.item)
    }
}
