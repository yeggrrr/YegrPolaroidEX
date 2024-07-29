//
//  OurTopicHeaderView.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit

final class OurTopicHeaderView: UICollectionReusableView {
    // MARK: UI
    private let containerView = UIView()
    let titleLabel = UILabel()
    
    // MARK: View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpHeaderView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Functions
    private func setUpHeaderView() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(containerView.snp.verticalEdges).inset(5)
            $0.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(10)
        }
        
        titleLabel.setUI(
            txtColor: .black,
            txtAlignment: .left,
            fontStyle: .systemFont(ofSize: 17, weight: .bold),
            numOfLines: 1)
    }
}
