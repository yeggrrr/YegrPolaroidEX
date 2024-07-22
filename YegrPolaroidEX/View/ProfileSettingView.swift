//
//  ProfileSettingView.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit
import SnapKit

final class ProfileSettingView: UIView, ViewRepresentable {
    private let profileView = UIView()
    private let profileBorderView = UIView()
    private let camerView = UIView()
    private let cameraImageView = UIImageView()
    var profileImageView = UIImageView()
    let profileTabGestureView = UIView()
    
    let mbtiLabel = UILabel()
    
    let mbtiStackView = UIStackView()
    
    let eiStackView = UIStackView()
    let eButton = UIButton()
    let iButton = UIButton()
    
    let snStackView = UIStackView()
    let sButton = UIButton()
    let nButton = UIButton()
    
    let tfStackView = UIStackView()
    let tButton = UIButton()
    let fButton = UIButton()
    
    let jpStackView = UIStackView()
    let jButton = UIButton()
    let pButton = UIButton()
    
    let nicknameTextField = UITextField()
    private let dividerView = UIView()
    let noticeLabel = UILabel()
    
    let completeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func addSubviews() {
        addSubviews([profileView, camerView, profileTabGestureView, nicknameTextField, dividerView, noticeLabel])
        profileView.addSubview(profileBorderView)
        profileBorderView.addSubview(profileImageView)
        camerView.addSubview(cameraImageView)
        
        addSubviews([mbtiLabel, mbtiStackView])
        mbtiStackView.addArrangedSubviews([eiStackView, snStackView, tfStackView, jpStackView])
        eiStackView.addArrangedSubviews([eButton, iButton])
        snStackView.addArrangedSubviews([sButton, nButton])
        tfStackView.addArrangedSubviews([tButton, fButton])
        jpStackView.addArrangedSubviews([jButton, pButton])
        
        addSubview(completeButton)
    }
    
    internal func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(150)
        }
        
        profileBorderView.snp.makeConstraints {
            $0.center.equalTo(profileView.snp.center)
            $0.width.height.equalTo(100)
        }
        
        profileImageView.snp.makeConstraints {
            $0.center.equalTo(profileBorderView.snp.center)
            $0.width.height.equalTo(100)
        }
        
        camerView.snp.makeConstraints {
            $0.trailing.equalTo(profileBorderView.snp.trailing)
            $0.bottom.equalTo(profileBorderView.snp.bottom)
            $0.width.height.equalTo(40)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.center.equalTo(camerView.snp.center)
            $0.width.height.equalTo(22)
        }
        
        profileTabGestureView.snp.makeConstraints {
            $0.edges.equalTo(profileBorderView)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(50)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(1)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(30)
        }
        
        mbtiLabel.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(30)
            $0.leading.equalTo(safeArea).offset(20)
            $0.height.equalTo(20)
            $0.width.lessThanOrEqualTo(50)
        }
        
        mbtiStackView.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(30)
            $0.leading.greaterThanOrEqualTo(mbtiLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(safeArea).offset(-20)
            $0.height.equalTo(120)
            $0.width.equalTo(250)
        }
        
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.bottom.equalTo(safeArea).offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    internal func configureUI() {
        profileView.backgroundColor = .white
        
        profileBorderView.layer.borderWidth = 3
        profileBorderView.layer.borderColor = UIColor.customPoint.cgColor
        
        profileBorderView.layoutIfNeeded()
        profileBorderView.layer.cornerRadius = profileBorderView.frame.width / 2
        profileBorderView.clipsToBounds = true
        
        profileImageView.contentMode = .scaleAspectFill
        
        camerView.layer.cornerRadius = 20
        camerView.backgroundColor = .customPoint
        
        cameraImageView.image = UIImage(systemName: "camera.fill")
        cameraImageView.tintColor = .white
        cameraImageView.layer.cornerRadius = 11
        
        nicknameTextField.setTextField(placeholderText: "닉네임을 입력해주세요 :)")
        
        noticeLabel.text = ""
        noticeLabel.textColor = .customPoint
        noticeLabel.font = .systemFont(ofSize: 13)
        noticeLabel.textAlignment = .left
        
        dividerView.backgroundColor = .systemGray4
        
        profileTabGestureView.backgroundColor = .clear
        profileTabGestureView.layer.cornerRadius = 65
        
        mbtiLabel.text = "MBTI"
        mbtiLabel.setUI(txtColor: .label, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .bold), numOfLines: 1)
        
        mbtiStackView.setUI(SVAxis: .horizontal, SVSpacing: 10, SVAlignment: .fill, SVDistribution: .fillEqually)
        eiStackView.setUI(SVAxis: .vertical, SVSpacing: 10, SVAlignment: .fill, SVDistribution: .fillEqually)
        
        snStackView.setUI(SVAxis: .vertical, SVSpacing: 10, SVAlignment: .fill, SVDistribution: .fillEqually)
        tfStackView.setUI(SVAxis: .vertical, SVSpacing: 10, SVAlignment: .fill, SVDistribution: .fillEqually)
        jpStackView.setUI(SVAxis: .vertical, SVSpacing: 10, SVAlignment: .fill, SVDistribution: .fillEqually)
        
        eButton.setMbtiUI(title: "E")
        iButton.setMbtiUI(title: "I")
        sButton.setMbtiUI(title: "S")
        nButton.setMbtiUI(title: "N")
        tButton.setMbtiUI(title: "T")
        fButton.setMbtiUI(title: "F")
        jButton.setMbtiUI(title: "J")
        pButton.setMbtiUI(title: "P")
        
        completeButton.setPointUI(title: "완료", bgColor: .incompleteColor)
    }
}
