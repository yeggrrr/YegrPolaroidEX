//
//  OnBoardingViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class OnBoardingViewController: UIViewController, ViewRepresentable {
    // MARK: UI
    private let logoLabel = UILabel()
    private let posterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let startButton = UIButton()
    
    // MARK: Properties
    private let disposeBag = DisposeBag()
    private let viewModel = OnBoadingViewModel()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        addSubviews()
        setConstraints()
        configureUI()
        bind()
    }
    
    // MARK: Functions
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
    
    func bind() {
        let input = OnBoadingViewModel.Input(startButtonTap: startButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.logoText
            .bind(with: self) { owner, value in
                owner.logoLabel.text = value
            }
            .disposed(by: disposeBag)
        
        output.posterImageName
            .bind(with: self) { owner, value in
                owner.posterImageView.image = UIImage(named: value)
            }
            .disposed(by: disposeBag)
        
        output.nameText
            .bind(with: self) { owner, value in
                owner.nameLabel.text = value
            }
            .disposed(by: disposeBag)
        
        output.startButtonText
            .bind(with: self) { owner, value in
                owner.startButton.setTitle(value, for: .normal)
            }
            .disposed(by: disposeBag)
        
        output.startButtonTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(ProfileSettingViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPointColor
        
        logoLabel.setUI(
            txtColor: .customPointColor,
            txtAlignment: .left,
            fontStyle: .systemFont(ofSize: 35, weight: .black),
            numOfLines: 2)
        
        nameLabel.setUI(
            txtColor: .black,
            txtAlignment: .center,
            fontStyle: .systemFont(ofSize: 20, weight: .heavy),
            numOfLines: 1)
        
        posterImageView.contentMode = .scaleAspectFill
        startButton.setPointUI(bgColor: .customPointColor)
    }
}

