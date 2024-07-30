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
    let saveButton = UIButton(type: .system)
    
    // MARK: Properties
    private let profileImageNameList = Array(0...11).map{ "profile_\($0)" }
    var viewType: ViewType = .new
    var isSaveButtonEnabled: Bool = false
    var saveButtonTintColor: UIColor = .clear
    
    private var sourceOfEnergy: (E: Bool, I: Bool) = (false, false)
    private var processingOfInfo: (S: Bool, N: Bool) = (false, false)
    private var decisionMaking: (T: Bool, F: Bool) = (false, false)
    private var needForStructure: (J: Bool, P: Bool) = (false, false)
    
    // MARK: View Life Cycle
    override func loadView() {
        view = profileSettingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        profileTabGesture()
        addButtonAction()
        bindData()
        setInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
        DismissKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if viewType == .update {
            UserDefaultsManager.userTempProfileImageName = nil
        }
    }
    
    // MARK: Functions
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
    
    private func configureUI() {
        // view
        view.backgroundColor = .white
        
        // tabBar
        tabBarController?.tabBar.isHidden = true
        
        // navigation
        navigationItem.title = "PROFILE SETTING"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPointColor
        
        saveButton.setTitle("저장", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        let saveBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
        saveButton.isEnabled = isSaveButtonEnabled
        saveButton.tintColor = saveButtonTintColor
        
        // textField
        profileSettingView.nicknameTextField.delegate = self
        profileSettingView.nicknameTextField.becomeFirstResponder()
        
        if let userTempProfileImageName = UserDefaultsManager.userTempProfileImageName {
            // 이미지 선택 화면을 진입한 적이 있는 경우
            profileSettingView.profileImageView.image = UIImage(named: userTempProfileImageName)
        } else {
            // 프로필 설정화면에 갓 진입한 경우
            profileSettingView.profileImageView.image = UIImage(named: UserDefaultsManager.fetchProfileImage())
        }
        
        // completeButton & saveButton
        profileSettingView.completeButton.isEnabled = false
    }
    
    private func setInitialData() {
        if viewType == .new {
            profileSettingView.deleteAccountButton.isHidden = true
            
            if let randomImageName = profileImageNameList.randomElement() {
                UserDefaultsManager.userTempProfileImageName = randomImageName
            }
        } else {
            profileSettingView.completeButton.isHidden = true
            profileSettingView.nicknameTextField.text = UserDefaultsManager.fetchName()
            profileSettingView.profileImageView.image = UIImage(named: UserDefaultsManager.fetchProfileImage())
            viewModel.inputText.value = UserDefaultsManager.fetchName()
            
            let udSourceOfEnergy = UserDefaultsManager.fetchSourceOfEnergy()
            let udProcessingOfInfo = UserDefaultsManager.fetchProcessingOfInfo()
            let udDecisionMaking = UserDefaultsManager.fetchDecisionMaking()
            let udNeedForStructure = UserDefaultsManager.fetchNeedForStructure()
            
            // 각각 저장된 MBTI String값에 따라서 대입
            if udSourceOfEnergy == "E" {
                sourceOfEnergy = (true, false)
                profileSettingView.eButton.isSelected = true
            } else if udSourceOfEnergy == "I" {
                sourceOfEnergy = (false, true)
                profileSettingView.iButton.isSelected = true
            }
            
            if udProcessingOfInfo == "S" {
                processingOfInfo = (true, false)
                profileSettingView.sButton.isSelected = true
            } else if udProcessingOfInfo == "N" {
                processingOfInfo = (false, true)
                profileSettingView.nButton.isSelected = true
            }
            
            if udDecisionMaking == "T" {
                decisionMaking = (true, false)
                profileSettingView.tButton.isSelected = true
            } else if udDecisionMaking == "F" {
                decisionMaking = (false, true)
                profileSettingView.fButton.isSelected = true
            }
            
            if udNeedForStructure == "J" {
                needForStructure = (true, false)
                profileSettingView.jButton.isSelected = true
            } else if udNeedForStructure == "P" {
                needForStructure = (false, true)
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
        profileSettingView.deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonClicked), for: .touchUpInside)
    }
    
    private func updateCompleteButton() {
        let eiState = sourceOfEnergy.E || sourceOfEnergy.I
        let nsState = processingOfInfo.N || processingOfInfo.S
        let tfState = decisionMaking.T || decisionMaking.F
        let fpState = needForStructure.J || needForStructure.P
        let nicknameState = viewModel.nicknameErrorMessage == .noError
        
        if nicknameState && eiState && nsState && tfState && fpState {
            saveButton.isEnabled = true
            profileSettingView.completeButton.isEnabled = true
            profileSettingView.completeButton.backgroundColor = .customPointColor
        } else {
            saveButton.isEnabled = false
            profileSettingView.completeButton.isEnabled = false
            profileSettingView.completeButton.backgroundColor = .incompleteColor
        }
    }
    
    private func saveMBTI() {
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
    }
    
    func DismissKeyboard(){
        profileSettingView.nicknameTextField.resignFirstResponder()
    }
    
    // Return 클릭 시 keyboard dismiss
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Actions
    @objc func profileImageTapped() {
        let vc = SelectImageViewController()
        isSaveButtonEnabled = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func completeButtonClicked() {
        // 닉네임 저장
        guard let userName = profileSettingView.nicknameTextField.text else { return }
        UserDefaultsManager.save(value: userName, key: .name)
        
        // 이미지 저장
        guard let userImage = UserDefaultsManager.userTempProfileImageName else { return }
        UserDefaultsManager.save(value: userImage, key: .profileImage)
        UserDefaultsManager.userTempProfileImageName = nil
        
        // MBTI 저장
        saveMBTI()
        
        UserDefaultsManager.save(value: true, key: .isExistUser)
        screenTransition(YegrPolaroidTabBarController())
    }
    
    @objc func saveButtonClicked() {
        if viewModel.nicknameErrorMessage == .noError {
            if let userTempProfileImageName = UserDefaultsManager.userTempProfileImageName {
                UserDefaultsManager.save(value: userTempProfileImageName, key: .profileImage)
                UserDefaultsManager.userTempProfileImageName = nil
            }
            
            if let userName = profileSettingView.nicknameTextField.text {
                UserDefaultsManager.save(value: userName, key: .name)
            }
            
            saveMBTI()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func deleteAccountButtonClicked() {
        showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?") { _ in
            
            for savedItem in PhotoRepository.shared.fetch() {
                self.deleteImageFromDucumentDirectory(directoryType: .poster, imageName: savedItem.imageID)
                self.deleteImageFromDucumentDirectory(directoryType: .profile, imageName: savedItem.imageID)
            }
            
            PhotoRepository.shared.deleteAll()
            
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.description)
            }
            
            self.screenTransition(OnBoardingViewController())
        }
    }
    
    @objc func eButtonClicked(_ sender: UIButton) {
        sourceOfEnergy = (!sourceOfEnergy.E, false)
        sender.isSelected = sourceOfEnergy.E
        profileSettingView.iButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
        DismissKeyboard()
    }
    
    @objc func iButtonClicked(_ sender: UIButton) {
        sourceOfEnergy = (false, !sourceOfEnergy.I)
        sender.isSelected = sourceOfEnergy.I
        profileSettingView.eButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
        DismissKeyboard()
    }
    
    @objc func sButtonClicked(_ sender: UIButton) {
        processingOfInfo = (!processingOfInfo.S, false)
        sender.isSelected = processingOfInfo.S
        profileSettingView.nButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
        DismissKeyboard()
    }
    
    @objc func nButtonClicked(_ sender: UIButton) {
        processingOfInfo = (false, !processingOfInfo.N)
        sender.isSelected = processingOfInfo.N
        profileSettingView.sButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
        DismissKeyboard()
    }
    
    @objc func tButtonClicked(_ sender: UIButton) {
        decisionMaking = (!decisionMaking.T, false)
        sender.isSelected = decisionMaking.T
        profileSettingView.fButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
        DismissKeyboard()
    }
    
    @objc func fButtonClicked(_ sender: UIButton) {
        decisionMaking = (false, !decisionMaking.F)
        sender.isSelected = decisionMaking.F
        profileSettingView.tButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
        DismissKeyboard()
    }
    
    @objc func jButtonClicked(_ sender: UIButton) {
        needForStructure = (!needForStructure.J, false)
        sender.isSelected = needForStructure.J
        profileSettingView.pButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
        DismissKeyboard()
    }
    
    @objc func pButtonClicked(_ sender: UIButton) {
        needForStructure = (false, !needForStructure.P)
        sender.isSelected = needForStructure.P
        profileSettingView.jButton.isSelected = false
        profileSettingView.updateButtonColor()
        
        self.viewModel.inputValidationState.value = ()
        DismissKeyboard()
    }
}

// MARK: UITextFieldDelegate
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.inputText.value = text
        self.viewModel.inputValidationState.value = ()
    }
    
    // 화면 터치 시, keyboard dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
