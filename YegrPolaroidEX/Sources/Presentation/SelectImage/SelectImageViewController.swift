//
//  SelectImageViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/22/24.
//

import UIKit

final class SelectImageViewController: UIViewController {
    // MARK: UI
    private let selectImageView = SelectImageView()
    private let profileImageNameList = Array(0...11).map{ "profile_\($0)" }
    
    // MARK: Properties
    private let viewModel = SelectImageViewModel()
    let cellSpacing: CGFloat = 0
    
    // MARK: View Life Cycle
    override func loadView() {
        view = selectImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollecionView()
        bindData()
    }
    
    // MARK: Functions
    private func bindData() {
        viewModel.inputImageName.bind { value in
            UserDefaultsManager.userTempProfileImageName = value
            self.selectImageView.profileImageView.image = UIImage(named: value)
            self.selectImageView.selectImageCollectionView.reloadData()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "SELECT IMAGE"
        
        if let userTempProfileImageName = UserDefaultsManager.userTempProfileImageName {
            /// 이미지 선택 화면에 들어간적 있는 경우
            selectImageView.profileImageView.image = UIImage(named: userTempProfileImageName)
        } else {
            /// 처음 들어가는 경우
            selectImageView.profileImageView.image = UIImage(named: UserDefaultsManager.fetchProfileImage())
        }
    }
    
    private func configureCollecionView() {
        selectImageView.selectImageCollectionView.dataSource = self
        selectImageView.selectImageCollectionView.delegate = self
        selectImageView.selectImageCollectionView.register(SelectImageCollectionViewCell.self, forCellWithReuseIdentifier: SelectImageCollectionViewCell.id)
    }
}

// MARK: UICollectionViewDataSource
extension SelectImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImageNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectImageCollectionViewCell.id, for: indexPath) as? SelectImageCollectionViewCell else { return UICollectionViewCell() }
        let imageName = profileImageNameList[indexPath.item]
        cell.profileImageView.image = UIImage(named: imageName)
        cell.configureImage(imageName: imageName)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension SelectImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputImageName.value = profileImageNameList[indexPath.item]
        bindData()
    }
}

extension SelectImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let size = CGSize(width: width / 4, height: width / 4)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
