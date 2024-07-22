//
//  ProfileSettingViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit

final class ProfileSettingViewController: UIViewController {
    // MARK: Enum
    enum ViewType {
        case new
        case update
    }
    
    // MARK: UI
    let viewModel = ProfileSettingViewModel()
    let profileSettingView = ProfileSettingView()
    
    // MARK: Properties
    private let profileImageNameList = Array(0...11).map{ "profile_\($0)" }
    var viewType: ViewType = .new
    
    
    // MARK: View Life Cycle
    override func loadView() {
        view = profileSettingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setInitialData()
        profileTabGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
    }
    
    // MARK: Functions
    private func configure() {
        view.backgroundColor = .white
        navigationItem.title = "PROFILE SETTING"
        
        // textField
        profileSettingView.nicknameTextField.delegate = self
        profileSettingView.nicknameTextField.becomeFirstResponder()
        
        if let userTempProfileImageName = UserDefaultsManager.userTempProfileImageName {
            /// 이미지 선택 화면을 진입한 적이 있는 경우
            profileSettingView.profileImageView.image = UIImage(named: userTempProfileImageName)
        } else {
            /// 프로필 설정화면에 갓 진입한 경우
            profileSettingView.profileImageView.image = UIImage(named: UserDefaultsManager.fetchProfileImage())
        }
    }
    
    private func bindData() {
        viewModel.outputValidationText.bind { value in
            self.profileSettingView.noticeLabel.text = value
        }
        
        viewModel.outputValidColor.bind { value in
            self.profileSettingView.noticeLabel.textColor = value ? .systemBlue : .systemPink
        }
    }
    
    private func setInitialData() {
        if viewType == .new {
            if let randomImageName = profileImageNameList.randomElement() {
                UserDefaultsManager.userTempProfileImageName = randomImageName
            }
        } else {
            profileSettingView.nicknameTextField.text = UserDefaultsManager.fetchName()
        }
    }
    
    private func profileTabGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingView.profileTabGestureView.addGestureRecognizer(tapGesture)
        profileSettingView.profileTabGestureView.isUserInteractionEnabled = true
    }
    
    
    // MARK: Actions
    @objc func profileImageTapped() {
        let vc = SelectImageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UITextFieldDelegate
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.inputText.value = text
        bindData()
    }
}
