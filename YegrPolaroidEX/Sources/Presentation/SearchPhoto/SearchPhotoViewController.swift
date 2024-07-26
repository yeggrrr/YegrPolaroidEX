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
    
    // MARK: Properties
    let viewModel = SearchViewModel()
    
    // MARK: View Life Cycle
    override func loadView() {
        view = searchPhotoView
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
    
    // MARK: Functions
    func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.inputSearchData.bind { searchData in
            self.searchPhotoView.collectionView.reloadData()
        }
        
        viewModel.isDataCountZero.bind { state in
            self.searchPhotoView.noticeLabel.isHidden = !state
        }
    }
    
    func configureUI() {
        // navigation
        navigationItem.title = "SEARCH PHOTO"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .customPoint
        
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.customPoint.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 2
        
        // searchBar
        searchPhotoView.searchBar.delegate = self
    }
    
    func configureCollectionView() {
        searchPhotoView.collectionView.delegate = self
        searchPhotoView.collectionView.dataSource = self
        searchPhotoView.collectionView.register(SearchPhotoCollectionViewCell.self, forCellWithReuseIdentifier: SearchPhotoCollectionViewCell.id)
        searchPhotoView.collectionView.showsVerticalScrollIndicator = false
    }
    
    private func dismissKeyboard() {
        searchPhotoView.searchBar.resignFirstResponder()
    }
    
    // MARK: Actions
    @objc func dismissButtonClicked() {
        dismiss(animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension SearchPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let searhList = viewModel.inputSearchData.value?.results else { return 0 }
        return searhList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCollectionViewCell.id, for: indexPath) as? SearchPhotoCollectionViewCell else { return UICollectionViewCell() }
        guard let item = viewModel.inputSearchData.value?.results[indexPath.item] else { return cell }
        cell.configureCell(item: item)
        return cell
    }
}

// MARK: UISearchBarDelegate
extension SearchPhotoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchText.value = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = viewModel.inputSearchText.value else { return }
        viewModel.seachAPIRequest(query: text, page: 1, orderBy: .latest)
        dismissKeyboard()
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
extension SearchPhotoViewController: UICollectionViewDelegate { 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
