//
//  OurTopicViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit

final class OurTopicViewController: UIViewController, ViewRepresentable {
    // MARK: UI
    let titleLabel = UILabel()
    
    // MARK: Properties
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSettingButton()
        addSubviews()
        setConstraints()
        configureUI()
    }
    
    func setUpSettingButton(){
        let selectedImage = UserDefaultsManager.fetchProfileImage()
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: selectedImage), for: .normal)
        menuBtn.layer.borderColor = UIColor.customPoint.cgColor
        menuBtn.layer.borderWidth = 2
        menuBtn.layer.cornerRadius = 20
        menuBtn.clipsToBounds = true
        menuBtn.addTarget(self, action: #selector(settingButtonClicked), for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40)
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 40)
        currWidth?.isActive = true
        currHeight?.isActive = true
        navigationItem.rightBarButtonItem = menuBarItem
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
    }
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(50)
        }
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        
        // navigaion
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPoint
        
        // titleLabel
        titleLabel.text = "OUR TOPIC"
        titleLabel.setUI(txtColor: .label, txtAlignment: .left, fontStyle: .systemFont(ofSize: 30, weight: .bold), numOfLines: 1)
    }
    
    @objc func settingButtonClicked() {
        print(#function)
        let vc = ProfileSettingViewController()
        vc.viewType = .update
        vc.isSaveButtonEnabled = true
        vc.saveButtonTintColor = .black
        navigationController?.pushViewController(vc, animated: true)
    }
}
