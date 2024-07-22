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
    
    var sourceOfEnergy: (E: Bool, I: Bool) = (false, false)
    var processingOfInfo: (S: Bool, N: Bool) = (false, false)
    var decisionMaking: (T: Bool, F: Bool) = (false, false)
    var needForStructure: (J: Bool, P: Bool) = (false, false)
    
    // MARK: View Life Cycle
    override func loadView() {
        view = profileSettingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setInitialData()
        profileTabGesture()
        addButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
    }
    
    // MARK: Functions
    private func configure() {
        // view
        view.backgroundColor = .white
        
        // navigation
        navigationItem.title = "PROFILE SETTING"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPoint
        
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
    
    private func addButtonAction() {
        profileSettingView.eButton.addTarget(self, action: #selector(eButtonClicked), for: .touchUpInside)
        profileSettingView.iButton.addTarget(self, action: #selector(iButtonClicked), for: .touchUpInside)
        profileSettingView.sButton.addTarget(self, action: #selector(sButtonClicked), for: .touchUpInside)
        profileSettingView.nButton.addTarget(self, action: #selector(nButtonClicked), for: .touchUpInside)
        profileSettingView.tButton.addTarget(self, action: #selector(tButtonClicked), for: .touchUpInside)
        profileSettingView.fButton.addTarget(self, action: #selector(fButtonClicked), for: .touchUpInside)
        profileSettingView.jButton.addTarget(self, action: #selector(jButtonClicked), for: .touchUpInside)
        profileSettingView.pButton.addTarget(self, action: #selector(pButtonClicked), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc func profileImageTapped() {
        let vc = SelectImageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func eButtonClicked(_ sender: UIButton) {
        sourceOfEnergy = (!sourceOfEnergy.E, false)
        sender.isSelected = sourceOfEnergy.E
        profileSettingView.iButton.isSelected = false
        profileSettingView.updateButtonColor()
    }
    
    @objc func iButtonClicked(_ sender: UIButton) {
        sourceOfEnergy = (false, !sourceOfEnergy.I)
        sender.isSelected = sourceOfEnergy.I
        profileSettingView.eButton.isSelected = false
        profileSettingView.updateButtonColor()
    }
    
    @objc func sButtonClicked(_ sender: UIButton) {
        processingOfInfo = (!processingOfInfo.S, false)
        sender.isSelected = processingOfInfo.S
        profileSettingView.nButton.isSelected = false
        profileSettingView.updateButtonColor()
    }
    
    @objc func nButtonClicked(_ sender: UIButton) {
        processingOfInfo = (false, !processingOfInfo.N)
        sender.isSelected = processingOfInfo.N
        profileSettingView.sButton.isSelected = false
        profileSettingView.updateButtonColor()
    }
    
    @objc func tButtonClicked(_ sender: UIButton) {
        decisionMaking = (!decisionMaking.T, false)
        sender.isSelected = decisionMaking.T
        profileSettingView.fButton.isSelected = false
        profileSettingView.updateButtonColor()
    }
    
    @objc func fButtonClicked(_ sender: UIButton) {
        decisionMaking = (false, !decisionMaking.F)
        sender.isSelected = decisionMaking.F
        profileSettingView.tButton.isSelected = false
        profileSettingView.updateButtonColor()
    }
    
    @objc func jButtonClicked(_ sender: UIButton) {
        needForStructure = (!needForStructure.J, false)
        sender.isSelected = needForStructure.J
        profileSettingView.pButton.isSelected = false
        profileSettingView.updateButtonColor()
    }
    
    @objc func pButtonClicked(_ sender: UIButton) {
        needForStructure = (false, !needForStructure.P)
        sender.isSelected = needForStructure.P
        profileSettingView.jButton.isSelected = false
        profileSettingView.updateButtonColor()
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
