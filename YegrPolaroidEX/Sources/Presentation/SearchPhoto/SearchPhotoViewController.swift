//
//  SearchPhotoViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit

final class SearchPhotoViewController: UIViewController {
    // MARK: UI
    let searchPhotoView = SearchPhotoView()
    
    // MARK: View Life Cycle
    override func loadView() {
        view = searchPhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollectionView()
    }
    
    // MARK: Functions
    func configureUI() {
        // navigation
        navigationItem.title = "SEARCH PHOTO"
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.customPoint.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 2
        
        // searchController
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색어를 입력해주세요"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = .label
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.isToolbarHidden = true
    }
    
    func configureCollectionView() {
        searchPhotoView.collectionView.delegate = self
        searchPhotoView.collectionView.dataSource = self
        searchPhotoView.collectionView.register(SearchPhotoCollectionViewCell.self, forCellWithReuseIdentifier: SearchPhotoCollectionViewCell.id)
        searchPhotoView.collectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: UICollectionViewDataSource
extension SearchPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCollectionViewCell.id, for: indexPath) as? SearchPhotoCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SearchPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let size = CGSize(width: width / 2, height: 250)
        return size
    }
}

// MARK: UICollectionViewDelegate
extension SearchPhotoViewController: UICollectionViewDelegate { }
