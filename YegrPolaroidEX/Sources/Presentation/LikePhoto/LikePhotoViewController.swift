//
//  LikePhotoViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import Toast

final class LikePhotoViewController: UIViewController {
    // MARK: Enum
    enum FilterType {
        case latest // 최신순
        case earliest // 오래된순
    }
    
    // MARK: UI
    let likePhotoView = LikePhotoView()
    let cellSpacing: CGFloat = 5
    
    // MARK: Properties
    let viewModel = LikePhotoViewModel()
    var filterType: FilterType = .latest
    var sortedList: [PhotoRealm] = []
    
    // MARK: View Life Cycle
    override func loadView() {
        view = likePhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollecionview()
        configureAction()
        bindData()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    // MARK: Functions
    func bindData() {
        viewModel.outputLikeCountStateTrigger.bind { _ in
            let isListEmpty = PhotoRepository.shared.count == 0
            self.likePhotoView.noticeLabel.isHidden = !isListEmpty
        }
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        
        // navigation
        navigationItem.title = "LIKE PHOTO"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPointColor
        
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.customPointColor.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 2
    }
    
    func configureCollecionview() {
        likePhotoView.collectionView.delegate = self
        likePhotoView.collectionView.dataSource = self
        likePhotoView.collectionView.register(LikePhotoCell.self, forCellWithReuseIdentifier: LikePhotoCell.id)
        likePhotoView.collectionView.showsVerticalScrollIndicator = false
    }
    
    func updateUI() {
        tabBarController?.tabBar.isHidden = false
        
        if likePhotoView.sortButton.isSelected {
            sortedList = decSort()
        } else {
            sortedList = ascSort()
        }
        
        likePhotoView.collectionView.reloadData()
        likePhotoView.noticeLabel.isHidden = !sortedList.isEmpty
    }
    
    func configureAction() {
        likePhotoView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    func ascSort() -> [PhotoRealm] {
        PhotoRepository.shared.fetch().sorted(by: { $0.savedTheDate < $1.savedTheDate })
    }
    
    func decSort() -> [PhotoRealm] {
        PhotoRepository.shared.fetch().sorted(by: { $0.savedTheDate > $1.savedTheDate })
    }
    
    // MARK: Actions
    @objc func likeButtonClicked(_ sender: UIButton) {
        let item = sortedList[sender.tag]
        
        let matchedItem = PhotoRepository.shared.fetch().first { photoRealm in
            photoRealm.imageID == item.imageID
        }
        
        if let matchedItem = matchedItem {
            // FileManager 삭제
            deleteImageFromDucumentDirectory(directoryType: .poster, imageName: matchedItem.imageID)
            deleteImageFromDucumentDirectory(directoryType: .profile, imageName: matchedItem.imageID)
            
            // Realm 삭제
            PhotoRepository.shared.delete(item: item)
            sortedList = PhotoRepository.shared.fetch()
            showToast(message: "좋아요 목록에서 삭제되었습니다! :)")
            likePhotoView.collectionView.reloadData()
            viewModel.inputLikeCountStateTrigger.value = ()
        }
    }
    
    @objc func sortButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        switch filterType {
        case .latest:
            sortedList = decSort()
            filterType = .earliest
        case .earliest:
            sortedList = ascSort()
            filterType = .latest
        }
        
        self.likePhotoView.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        likePhotoView.collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension LikePhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikePhotoCell.id, for: indexPath) as? LikePhotoCell else { return UICollectionViewCell() }
        let item = sortedList[indexPath.item]
        let fmImage = loadImageFromDocumentDirectory(directoryType: .poster, imageName: item.imageID)
        cell.posterImage.image = fmImage
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension LikePhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = sortedList[indexPath.item]
        let vc = DetailViewController()
        vc.viewType = .likeTab
        vc.realmLikeModel = item
        vc.index = indexPath.item
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension LikePhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - cellSpacing
        let size = CGSize(width: width / 2, height: 250)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
