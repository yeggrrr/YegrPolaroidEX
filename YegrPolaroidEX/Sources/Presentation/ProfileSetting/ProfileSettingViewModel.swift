//
//  ProfileSettingViewModel.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//


import Foundation

final class ProfileSettingViewModel {
    // MARK: Enum
    enum NicknameErrorMessage: String {
        case empty = ""
        case wrongLength = "2글자 이상 10글자 미만으로 설정해주세요"
        case containsSpecialCharacter = "닉네임에 @, #, $, %는 포함할 수 없어요"
        case containsNumber = "닉네임에 숫자는 포함할 수 없어요"
        case noError = "사용할 수 있는 닉네임이에요"
    }
    
    // MARK: Properties
    var inputText = Observable("")
    var inputValidationState: Observable<Void?> = Observable(nil)
    
    var outputValidationText = Observable("")
    var outputValidColor = Observable(false)
    var outputValidationState: Observable<Void?> = Observable(nil)
    
    var nicknameErrorMessage: NicknameErrorMessage = .empty
    
    // MARK: Init
    init() {
        inputText.bind { value in
            self.validation(inputText: value)
        }
        
        inputValidationState.bind { _ in
            self.outputValidationState.value = ()
        }
    }
    
    // MARK: Functions
    private func validation(inputText: String) {
        var errors: [NicknameErrorMessage] = []
        
        if inputText.isEmpty {
            outputValidationText.value = NicknameErrorMessage.empty.rawValue
            return
        }
        
        for char in inputText {
            if inputText.count < 2 || inputText.count > 10 {
                errors.append(.wrongLength)
            } else if inputText.contains("@") || inputText.contains("#") || inputText.contains("$") || inputText.contains("%") {
                errors.append(.containsSpecialCharacter)
            } else if Int(String(char)) != nil {
                errors.append(.containsNumber)
            }
        }
        
        if let lastError = errors.last {
            outputValidColor.value = false
            nicknameErrorMessage = lastError
            outputValidationText.value = lastError.rawValue
        } else {
            outputValidColor.value = true
            nicknameErrorMessage = .noError
            outputValidationText.value = NicknameErrorMessage.noError.rawValue
        }
    }
}
