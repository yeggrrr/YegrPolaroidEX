//
//  LikePhotoViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import Toast

// TODO: 해당 화면에서 뒤에서 부터 삭제 시, index 정보가 꼬인 것 같음. 다른 사진이 삭제됨
final class LikePhotoViewController: UIViewController {
    // MARK: UI
    let likePhotoView = LikePhotoView()
    let cellSpacing: CGFloat = 5
    
    // MARK: Properties
    let viewModel = LikePhotoViewModel()
    
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
        navigationItem.backBarButtonItem?.tintColor = .customPoint
        
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.customPoint.cgColor
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
        likePhotoView.collectionView.reloadData()
        
        let isListEmpty = PhotoRepository.shared.count == 0
        likePhotoView.noticeLabel.isHidden = !isListEmpty
    }
    
    func configureAction() {
        likePhotoView.latestButton.addTarget(self, action: #selector(latestButtonClicked), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc func likeButtonClicked(_ sender: UIButton) {
        let item = PhotoRepository.shared.fetch()[sender.tag]
        let imageID = item.imageID
        
        // Realm 삭제
        PhotoRepository.shared.delete(item: item)
        
        // FileManager 삭제
        deleteImageFromDucumentDirectory(directoryType: .poster, imageName: imageID)
        deleteImageFromDucumentDirectory(directoryType: .profile, imageName: imageID)
        
        showToast(message: "좋아요 목록에서 삭제되었습니다! :)")
        likePhotoView.collectionView.reloadData()
        viewModel.inputLikeCountStateTrigger.value = ()
    }
    
    @objc func latestButtonClicked() {
        print(#function)
    }
}

// MARK: UICollectionViewDataSource
extension LikePhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoRepository.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikePhotoCell.id, for: indexPath) as? LikePhotoCell else { return UICollectionViewCell() }
        let item = PhotoRepository.shared.fetch()[indexPath.item]
        let fmImage = loadImageFromDocumentDirectory(directoryType: .poster, imageName: item.imageID)
        cell.posterImage.image = fmImage
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
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

// MARK: UICollectionViewDelegate
extension LikePhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = PhotoRepository.shared.fetch()[indexPath.item]
        let vc = DetailViewController()
        vc.viewType = .likeTab
        vc.realmLikeModel = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
