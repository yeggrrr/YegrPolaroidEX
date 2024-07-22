//
//  OnBoardingViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController, ViewRepresentable {
    // MARK: UI
    let logoLabel = UILabel()
    let posterImageView = UIImageView()
    let nameLabel = UILabel()
    let startButton = UIButton()
    
    // MARK: Properties
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        addSubviews()
        setConstraints()
        configure()
    }
    
    func addSubviews() {
        view.addSubviews([logoLabel, posterImageView, nameLabel, startButton])
    }
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        logoLabel.snp.makeConstraints {
            $0.bottom.equalTo(posterImageView.snp.top).offset(-30)
            $0.horizontalEdges.equalTo(safeArea).inset(30)
            $0.height.equalTo(85)
        }
        
        posterImageView.snp.makeConstraints {
            $0.bottom.equalTo(nameLabel.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(posterImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(startButton.snp.top).offset(-100)
            $0.horizontalEdges.equalTo(safeArea).inset(30)
            $0.height.equalTo(30)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(safeArea).offset(-20)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(50)
        }
    }
    
    func configure() {
        view.backgroundColor = .white
        
        logoLabel.text = "HELLO\nMY MEMORIES"
        logoLabel.setUI(
            txtColor: .customPoint,
            txtAlignment: .left,
            fontStyle: .systemFont(ofSize: 35, weight: .black),
            numOfLines: 2)
        
        posterImageView.image = UIImage(named: "launchImage")
        posterImageView.contentMode = .scaleAspectFill
        
        nameLabel.text = "김예진"
        nameLabel.setUI(
            txtColor: .label,
            txtAlignment: .center,
            fontStyle: .systemFont(ofSize: 20, weight: .heavy),
            numOfLines: 1)
        
        startButton.setPointUI(title: "시작하기", bgColor: .customPoint)
    }
}

