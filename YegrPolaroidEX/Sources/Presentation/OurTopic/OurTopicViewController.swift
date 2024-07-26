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
    let viewModel = OurTopicViewModel()
    private let sectionList: [SectionType] = [.goldenHour, .business, .interior]
    
    // MARK: View Life Cycle
    override func loadView() {
        view = ourTopicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        configureUI()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.inputCallRequestCompleteTrigger.bind { _ in
            self.ourTopicView.collectionView.reloadData()
        }
        
        viewModel.inputGoldenHourDetailData.bind { _ in
            print(">>> inputGoldenHourDetailData 도착!")
        }
        
        viewModel.outputGoldenHourData.bind { value in
            print(">>> outputGoldenHourData 도착!", value)
        }
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        
        // navigaion
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPoint
        
        // rightBarButtonItem
        let selectedImage = UserDefaultsManager.fetchProfileImage()
        
        let profileBtn = UIButton(type: .custom)
        profileBtn.setImage(UIImage(named: selectedImage), for: .normal)
        profileBtn.layer.borderColor = UIColor.customPoint.cgColor
        profileBtn.layer.borderWidth = 2
        profileBtn.layer.cornerRadius = 20
        profileBtn.clipsToBounds = true
        profileBtn.addTarget(self, action: #selector(settingButtonClicked), for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: profileBtn)
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
        ourTopicView.collectionView.register(OurTopicHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OurTopicHeaderView.id)
        ourTopicView.collectionView.showsVerticalScrollIndicator = false
    }
    
    @objc func settingButtonClicked() {
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: OurTopicHeaderView.id, for: indexPath) as? OurTopicHeaderView else { return UICollectionReusableView() }
            switch sectionList[indexPath.section] {
            case .goldenHour:
                headerView.titleLabel.text = "골든 아워"
            case .business:
                headerView.titleLabel.text = "비즈니스 및 업무"
            case .interior:
                headerView.titleLabel.text = "건축 및 인테리어"
            }
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
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
            cell.goldenHourData = viewModel.inputGoldenHourData.value
            cell.goldenHourCollectionView.reloadData()
            cell.pushDelegate = self
            cell.itemIndexDelegate = self
            return cell
        case .business:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusinessCell.id, for: indexPath) as? BusinessCell else { return UICollectionViewCell() }
            cell.businessData = viewModel.inputBusinessData.value
            cell.businessCollectionView.reloadData()
            cell.delegate = self
            return cell
        case .interior:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InteriorCell.id, for: indexPath) as? InteriorCell else { return UICollectionViewCell() }
            cell.interiorData = viewModel.inputInteriorData.value
            cell.interiorCollectionView.reloadData()
            cell.delegate = self
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OurTopicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let size = CGSize(width: width, height: 230)
        return size
    }
}

// MARK: UICollectionViewDelegate
extension OurTopicViewController: UICollectionViewDelegate { }

extension OurTopicViewController: PushDelegate {
    func pushDetailView() {
        let vc = DetailViewController()
        vc.detailData = viewModel.inputGoldenHourDetailData.value
        vc.statisticData = viewModel.outputGoldenHourData.value
        print(">>>> \(viewModel.outputGoldenHourData.value)")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension OurTopicViewController: itemIndexDelegate {
    func itemIndex(index: Int) {
        viewModel.inputGoldenHourDetailData.value = viewModel.inputGoldenHourData.value[index]
        viewModel.inputGolendHourId.value = viewModel.inputGoldenHourData.value[index].id
    }
}
