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
    let sortButton = UIButton(type: .system)
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
        
        sortButton.layer.cornerRadius = sortButton.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubviews([filterbuttonView, collectionView, noticeLabel])
        filterbuttonView.addSubview(sortButton)
    }
    
    func setConstraints() {
        let safeArea = safeAreaLayoutGuide
  
        filterbuttonView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(40)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(filterbuttonView.snp.top)
            $0.trailing.equalTo(filterbuttonView.snp.trailing).offset(-5)
            $0.bottom.equalTo(filterbuttonView.snp.bottom).offset(-5)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filterbuttonView.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges)
            $0.bottom.equalTo(safeArea)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.center.equalTo(collectionView.snp.center)
            $0.horizontalEdges.equalTo(collectionView.snp.horizontalEdges).inset(20)
        }
    }
    
    func configureUI() {
        // view
        backgroundColor = .white
        
        // sortButton
        let config = UIButton.Configuration.plain()
        sortButton.configuration = config
        sortButton.layer.borderWidth = 1
        sortButton.layer.borderColor = UIColor.lightGray.cgColor
        sortButton.setBackgroundColor(color: .white, forState: .normal)
        sortButton.setBackgroundColor(color: .customPoint, forState: .selected)
        sortButton.configurationUpdateHandler = { btn in
            var container = AttributeContainer()
            container.font = .systemFont(ofSize: 17, weight: .semibold)
            
            var configuration = btn.configuration
            configuration?.image = UIImage(named: "sort")
            configuration?.imagePadding = 5
            configuration?.imagePlacement = .leading
            configuration?.baseForegroundColor = .black
            
            switch btn.state {
            case .selected:
                container.foregroundColor = .black
                configuration?.background.backgroundColor = .customPoint
                configuration?.attributedTitle = AttributedString("최신순", attributes: container)
            case .highlighted:
                break
            default:
                container.foregroundColor = .black
                configuration?.background.backgroundColor = .white
                configuration?.attributedTitle = AttributedString("과거순", attributes: container)
            }
            
            btn.configuration = configuration
        }
        
        // noticeLabel
        noticeLabel.text = "저장된 사진이 없습니다."
        noticeLabel.setUI(
            txtColor: .black,
            txtAlignment: .center,
            fontStyle: .systemFont(ofSize: 17, weight: .bold),
            numOfLines: 1)
    }
}
