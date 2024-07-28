//
//  LikePhotoViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit

final class LikePhotoViewController: UIViewController {
    // MARK: UI
    let likePhotoView = LikePhotoView()
    let cellSpacing: CGFloat = 5
    
    // MARK: View Life Cycle
    override func loadView() {
        view = likePhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollecionview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        likePhotoView.collectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
        
        let isListEmpty = PhotoRepository.shared.count == 0
        likePhotoView.noticeLabel.isHidden = !isListEmpty
    }
    
    // MARK: Functions
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
    
    // MARK: Actions
    @objc func likeButtonClicked(_ sender: UIButton) {
        let item = PhotoRepository.shared.fetch()[sender.tag]
        let imageID = item.imageID
        
        // Realm 삭제
        PhotoRepository.shared.delete(item: item)
        
        // FileManager 삭제
        deleteImageFromDucumentDirectory(directoryType: .poster, imageName: imageID)
        deleteImageFromDucumentDirectory(directoryType: .profile, imageName: imageID)
        
        likePhotoView.collectionView.reloadData()
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
