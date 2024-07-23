//
//  ProfileSettingViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit

// TODO: MBTI Button 기능 - View로 옮기기

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
        profileTabGesture()
        addButtonAction()
        bindData()
        setInitialData()
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
        
        // completeButton
        profileSettingView.completeButton.isEnabled = false
    }
    
    private func bindData() {
        viewModel.outputValidationText.bind { value in
            self.profileSettingView.noticeLabel.text = value
        }
        
        viewModel.outputValidColor.bind { value in
            self.profileSettingView.noticeLabel.textColor = value ? .systemBlue : .systemPink
        }
        
        viewModel.outputValidationState.bind { _ in
            self.updateCompleteButton()
        }
    }
    
    private func setInitialData() {
        if viewType == .new {
            if let randomImageName = profileImageNameList.randomElement() {
                UserDefaultsManager.userTempProfileImageName = randomImageName
            }
        } else {
            profileSettingView.nicknameTextField.text = UserDefaultsManager.fetchName()
            
            let udSourceOfEnergy = UserDefaultsManager.fetchSourceOfEnergy()
            let udProcessingOfInfo = UserDefaultsManager.fetchProcessingOfInfo()
            let udDecisionMaking = UserDefaultsManager.fetchDecisionMaking()
            let udNeedForStructure = UserDefaultsManager.fetchNeedForStructure()
            
            /// 각각 저장된 MBTI String값에 따라서 대입
            if udSourceOfEnergy == "E" {
                sourceOfEnergy = (true, false)
                profileSettingView.eButton.isSelected = true
            } else if udSourceOfEnergy == "I" {
                sourceOfEnergy = (false, true)
                profileSettingView.iButton.isSelected = true
            }
            
            if udProcessingOfInfo == "S" {
                sourceOfEnergy = (true, false)
                profileSettingView.sButton.isSelected = true
            } else if udProcessingOfInfo == "N" {
                sourceOfEnergy = (false, true)
                profileSettingView.nButton.isSelected = true
            }
            
            if udDecisionMaking == "T" {
                sourceOfEnergy = (true, false)
                profileSettingView.tButton.isSelected = true
            } else if udDecisionMaking == "F" {
                sourceOfEnergy = (false, true)
                profileSettingView.fButton.isSelected = true
            }
            
            if udNeedForStructure == "J" {
                sourceOfEnergy = (true, false)
                profileSettingView.jButton.isSelected = true
            } else if udNeedForStructure == "P" {
                sourceOfEnergy = (false, true)
                profileSettingView.pButton.isSelected = true
            }
            
            profileSettingView.updateButtonColor()
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
        profileSettingView.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    private func updateCompleteButton() {
        let eiState = sourceOfEnergy.E || sourceOfEnergy.I
        let nsState = processingOfInfo.N || processingOfInfo.S
        let tfState = decisionMaking.T || decisionMaking.F
        let fpState = needForStructure.J || needForStructure.P
        let nicknameState = viewModel.nicknameErrorMessage == .noError
        
        if nicknameState && eiState && nsState && tfState && fpState {
            profileSettingView.completeButton.isEnabled = true
            profileSettingView.completeButton.backgroundColor = .customPoint
        } else {
            profileSettingView.completeButton.isEnabled = false
            profileSettingView.completeButton.backgroundColor = .incompleteColor
        }
    }
    
    // MARK: Actions
    @objc func profileImageTapped() {
        let vc = SelectImageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func completeButtonClicked() {
        /// 닉네임 저장
        guard let userName = profileSettingView.nicknameTextField.text else { return }
        UserDefaultsManager.save(value: userName, key: .name)
        
        /// 이미지 저장
        guard let userImage = UserDefaultsManager.userTempProfileImageName else { return }
        UserDefaultsManager.save(value: userImage, key: .profileImage)
        UserDefaultsManager.userTempProfileImageName = nil
        
        /// MBTI 저장
        if sourceOfEnergy.E {
            UserDefaultsManager.save(value: "E", key: .sourceOfEnergy)
        } else if sourceOfEnergy.I {
            UserDefaultsManager.save(value: "I", key: .sourceOfEnergy)
        }
        
        if processingOfInfo.N {
            UserDefaultsManager.save(value: "N", key: .processingOfInfo)
        } else if processingOfInfo.S {
            UserDefaultsManager.save(value: "S", key: .processingOfInfo)
        }
        
        if decisionMaking.T {
            UserDefaultsManager.save(value: "T", key: .decisionMaking)
        } else if decisionMaking.F {
            UserDefaultsManager.save(value: "F", key: .decisionMaking)
        }
        
        if needForStructure.J {
            UserDefaultsManager.save(value: "J", key: .needForStructure)
        } else if needForStructure.P {
            UserDefaultsManager.save(value: "P", key: .needForStructure)
        }
        
        UserDefaultsManager.save(value: true, key: .isExistUser)
        screenTransition(YegrPolaroidTabBarController())
    }
    
    @objc func eButtonClicked(_ sender: UIButton) {
        sourceOfEnergy = (!sourceOfEnergy.E, false)
        sender.isSelected = sourceOfEnergy.E
        profileSettingView.iButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
    }
    
    @objc func iButtonClicked(_ sender: UIButton) {
        sourceOfEnergy = (false, !sourceOfEnergy.I)
        sender.isSelected = sourceOfEnergy.I
        profileSettingView.eButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
    }
    
    @objc func sButtonClicked(_ sender: UIButton) {
        processingOfInfo = (!processingOfInfo.S, false)
        sender.isSelected = processingOfInfo.S
        profileSettingView.nButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
    }
    
    @objc func nButtonClicked(_ sender: UIButton) {
        processingOfInfo = (false, !processingOfInfo.N)
        sender.isSelected = processingOfInfo.N
        profileSettingView.sButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
    }
    
    @objc func tButtonClicked(_ sender: UIButton) {
        decisionMaking = (!decisionMaking.T, false)
        sender.isSelected = decisionMaking.T
        profileSettingView.fButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
    }
    
    @objc func fButtonClicked(_ sender: UIButton) {
        decisionMaking = (false, !decisionMaking.F)
        sender.isSelected = decisionMaking.F
        profileSettingView.tButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
    }
    
    @objc func jButtonClicked(_ sender: UIButton) {
        needForStructure = (!needForStructure.J, false)
        sender.isSelected = needForStructure.J
        profileSettingView.pButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
    }
    
    @objc func pButtonClicked(_ sender: UIButton) {
        needForStructure = (false, !needForStructure.P)
        sender.isSelected = needForStructure.P
        profileSettingView.jButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
    }
}

// MARK: UITextFieldDelegate
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.inputText.value = text
        self.viewModel.inputValidationState.value = ()
    }
}
