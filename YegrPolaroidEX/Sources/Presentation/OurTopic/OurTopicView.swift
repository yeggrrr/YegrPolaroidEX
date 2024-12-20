//
//  OurTopicView.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit

final class OurTopicView: UIView, ViewRepresentable {
    // MARK: UI
    private let titleLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    // MARK: View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Functions
    func addSubviews() {
        addSubviews([titleLabel, collectionView])
    }
    
    func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges).inset(10)
            $0.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges)
            $0.bottom.equalTo(safeArea)
        }
    }
    
    func configureUI() {
        titleLabel.text = "OUR TOPIC"
        titleLabel.setUI(
            txtColor: .black,
            txtAlignment: .left,
            fontStyle: .systemFont(ofSize: 32, weight: .bold),
            numOfLines: 1)
    }
}
