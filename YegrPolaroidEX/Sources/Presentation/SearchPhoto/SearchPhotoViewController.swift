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
    var page = 1
    
    // MARK: View Life Cycle
    override func loadView() {
        view = searchPhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        configureUI()
        configureCollectionView()
        configureAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Functions
    func bindData() {
        viewModel.viewDidLoadTrigger.value = ()
        
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
        searchPhotoView.collectionView.prefetchDataSource = self
    }
    
    func configureAction() {
        searchPhotoView.latestButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    private func dismissKeyboard() {
        searchPhotoView.searchBar.resignFirstResponder()
    }
    
    // MARK: Actions
    @objc func sortButtonClicked(_ sender: UIButton) {
        print(#function)
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.backgroundColor = .customPoint
            viewModel.inputCurrentSortType.value = .latest
        } else {
            sender.backgroundColor = .white
            viewModel.inputCurrentSortType.value = .relevant
        }
        
        self.searchPhotoView.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func dismissButtonClicked() {
        dismiss(animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension SearchPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.inputSearchData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCollectionViewCell.id, for: indexPath) as? SearchPhotoCollectionViewCell else { return UICollectionViewCell() }
        let item = viewModel.inputSearchData.value[indexPath.item]
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
        viewModel.seachAPIRequest(query: text, page: page, orderBy: viewModel.inputCurrentSortType.value)
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


// MARK: UICollectionViewDataSourcePrefetching
extension SearchPhotoViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let total = viewModel.inputTotalCount.value else { return }
        guard let text = viewModel.inputSearchText.value else { return }
        let searchData = viewModel.inputSearchData.value
        
        for indexPath in indexPaths {
            if total - searchData.count != 0 && searchData.count - 10 == indexPath.item {
                page += 1
                APICall.shared.callRequest(api: .search(query: text, page: page, orderBy: viewModel.inputCurrentSortType.value), model: SearchModel.self) { result in
                    self.viewModel.inputSearchData.value.append(contentsOf: result.results)
                } errorHandler: { error in
                    print("실패!! - \(error)")
                }
            }
        }
    }
}

