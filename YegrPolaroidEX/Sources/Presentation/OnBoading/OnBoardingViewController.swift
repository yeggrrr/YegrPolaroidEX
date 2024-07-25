//
//  OnBoardingViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit
import SnapKit

final class OnBoardingViewController: UIViewController, ViewRepresentable {
    // MARK: UI
    private let logoLabel = UILabel()
    private let posterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let startButton = UIButton()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        addSubviews()
        setConstraints()
        configureUI()
        configureAction()
    }
    
    // MARK: Functions
    internal func addSubviews() {
        view.addSubviews([logoLabel, posterImageView, nameLabel, startButton])
    }
    
    internal func setConstraints() {
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
    
    internal func configureUI() {
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPoint
        
        logoLabel.text = "HELLO ◡̎\nMY MEMORIES"
        logoLabel.setUI(
            txtColor: .customPoint,
            txtAlignment: .left,
            fontStyle: .systemFont(ofSize: 35, weight: .black),
            numOfLines: 2)
        
        posterImageView.image = UIImage(named: "launchPosterImage")
        posterImageView.contentMode = .scaleAspectFill
        
        nameLabel.text = "김예진"
        nameLabel.setUI(
            txtColor: .label,
            txtAlignment: .center,
            fontStyle: .systemFont(ofSize: 20, weight: .heavy),
            numOfLines: 1)
        
        startButton.setPointUI(title: "시작하기", bgColor: .customPoint)
    }
    
    private func configureAction() {
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc func startButtonClicked() {
        let vc = ProfileSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

