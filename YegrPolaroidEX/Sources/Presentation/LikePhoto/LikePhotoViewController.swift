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
    
    // MARK: View Life Cycle
    override func loadView() {
        view = likePhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollecionview()
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
}

// MARK: UICollectionViewDataSource
extension LikePhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikePhotoCell.id, for: indexPath) as? LikePhotoCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension LikePhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let size = CGSize(width: width / 2, height: 250)
        return size
    }
}

// MARK: UICollectionViewDelegate
extension LikePhotoViewController: UICollectionViewDelegate { }

