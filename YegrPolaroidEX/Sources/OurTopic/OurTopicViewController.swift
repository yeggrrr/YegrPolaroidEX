//
//  OurTopicViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import SnapKit

final class OurTopicViewController: UIViewController {
    // MARK: Enum
    private enum SectionType {
        case goldenHour
        case business
        case interior
    }
    
    // MARK: UI
    let ourTopicView = OurTopicView()
    
    // MARK: Properties
    private let sectionList: [SectionType] = [.goldenHour, .business, .interior]
    
    // MARK: View Life Cycle
    override func loadView() {
        view = ourTopicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollectionView()
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        
        // navigaion
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPoint
        
        // rightBarButtonItem
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
    
    func configureCollectionView() {
        ourTopicView.collectionView.delegate = self
        ourTopicView.collectionView.dataSource = self
        ourTopicView.collectionView.register(GoldenHourCell.self, forCellWithReuseIdentifier: GoldenHourCell.id)
        ourTopicView.collectionView.register(BusinessCell.self, forCellWithReuseIdentifier: BusinessCell.id)
        ourTopicView.collectionView.register(InteriorCell.self, forCellWithReuseIdentifier: InteriorCell.id)
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

// MARK: UICollectionViewDataSource
extension OurTopicViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionList.count
    }
    
    // func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //     <#code#>
    // }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionList[section] {
        case .goldenHour, .business, .interior:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sectionList[indexPath.section] {
        case .goldenHour:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoldenHourCell.id, for: indexPath) as? GoldenHourCell else { return UICollectionViewCell() }
            return cell
        case .business:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusinessCell.id, for: indexPath) as? BusinessCell else { return UICollectionViewCell() }
            return cell
        case .interior:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InteriorCell.id, for: indexPath) as? InteriorCell else { return UICollectionViewCell() }
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OurTopicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        
        switch sectionList[section] {
        case .goldenHour, .business, .interior:
            return CGSize(width: width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sectionList[indexPath.section] {
        case .goldenHour, .business, .interior:
            let width = collectionView.frame.width
            let size = CGSize(width: width, height: 220)
            return size
        }
    }
}

extension OurTopicViewController: UICollectionViewDelegate { }
