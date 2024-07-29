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
    enum SectionType {
        case goldenHour
        case business
        case interior
    }
    
    // MARK: UI
    private let ourTopicView = OurTopicView()
    
    // MARK: Properties
    private let viewModel = OurTopicViewModel()
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
        
        configureUI()
    }
    
    // MARK: Functions
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.inputCallRequestCompleteTrigger.bind { value in
            self.ourTopicView.collectionView.reloadData()
        }
    }
    
    private func configureUI() {
        // view
        view.backgroundColor = .white
        
        // tabBar
        tabBarController?.tabBar.isHidden = false
        
        // navigaion
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPoint
        
        // rightBarButtonItem
        let selectedImage = UserDefaultsManager.fetchProfileImage()
        
        let profileBtn = UIButton(type: .custom)
        profileBtn.topProfileUI(imageName: selectedImage)
        profileBtn.addTarget(self, action: #selector(settingButtonClicked), for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: profileBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40)
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 40)
        currWidth?.isActive = true
        currHeight?.isActive = true
        navigationItem.rightBarButtonItem = menuBarItem
    }
    
    private func configureCollectionView() {
        ourTopicView.collectionView.delegate = self
        ourTopicView.collectionView.dataSource = self
        ourTopicView.collectionView.register(GoldenHourCell.self, forCellWithReuseIdentifier: GoldenHourCell.id)
        ourTopicView.collectionView.register(BusinessCell.self, forCellWithReuseIdentifier: BusinessCell.id)
        ourTopicView.collectionView.register(InteriorCell.self, forCellWithReuseIdentifier: InteriorCell.id)
        ourTopicView.collectionView.register(OurTopicHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OurTopicHeaderView.id)
        ourTopicView.collectionView.showsVerticalScrollIndicator = false
    }
    
    // MARK: Actions
    @objc func settingButtonClicked() {
        let vc = ProfileSettingViewController()
        vc.viewType = .update
        vc.isSaveButtonEnabled = false
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

// MARK: UICollectionViewDelegate
extension OurTopicViewController: UICollectionViewDelegate { }

extension OurTopicViewController: PushDelegate {
    func pushDetailView(sectionType: SectionType, index: Int) {
        let vc = DetailViewController()
        vc.ourTopicViewModel = viewModel
        
        let item = switch sectionType {
        case .goldenHour:
            viewModel.inputGoldenHourData.value[index]
        case .business:
            viewModel.inputBusinessData.value[index]
        case .interior:
            viewModel.inputInteriorData.value[index]
        }
        
        let createdDateText = "\(DateFormatter.dateToContainLetter(dateString: item.createdAt)) 게시됨"
        
        vc.detailUIModel = DetailUIModel(
            imageID: item.id,
            profileImage: item.user.profileImage.medium,
            userName: item.user.name,
            createdDate: createdDateText,
            posterImage: item.urls.small,
            sizeInfo: "\(item.width) x \(item.height)",
            viewsInfo: nil,
            downloadInfo: nil,
            savedTheDate: Date())
        
        navigationController?.pushViewController(vc, animated: true)
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

// MARK: itemIndexDelegate
extension OurTopicViewController: itemIndexDelegate {
    func itemIndex(index: Int) {
        viewModel.inputGoldenHourDetailData.value = viewModel.inputGoldenHourData.value[index]
        viewModel.inputGolendHourId.value = viewModel.inputGoldenHourData.value[index].id
    }
}
