//
//  SearchPhotoViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit
import Kingfisher

final class SearchPhotoViewController: UIViewController {
    // MARK: UI
    private let searchPhotoView = SearchPhotoView()
    
    // MARK: Properties
    private let viewModel = SearchViewModel()
    var detailUIModel: DetailUIModel?
    let cellSpacing: CGFloat = 5
    private var page = 1
    var index: Int?
    var liked: Bool?
    
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
        searchPhotoView.collectionView.reloadData()
    }
    
    // MARK: Functions
    private func bindData() {
        viewModel.inputSearchData.bind { searchData in
            self.searchPhotoView.collectionView.reloadData()
        }
        
        viewModel.isDataCountZero.bind { state in
            self.searchPhotoView.noticeLabel.isHidden = !state
        }
        
        viewModel.inputStatisticData.bind { statisticData in
            self.save(statisticItem: statisticData)
        }
    }
    
    private func configureUI() {
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
    
    private func configureCollectionView() {
        searchPhotoView.collectionView.delegate = self
        searchPhotoView.collectionView.dataSource = self
        searchPhotoView.collectionView.register(SearchPhotoCell.self, forCellWithReuseIdentifier: SearchPhotoCell.id)
        searchPhotoView.collectionView.showsVerticalScrollIndicator = false
        searchPhotoView.collectionView.prefetchDataSource = self
        searchPhotoView.collectionView.keyboardDismissMode = .onDrag
    }
    
    private func configureAction() {
        searchPhotoView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    private func save(statisticItem: StatisticsData?){
        guard let statisticItem = statisticItem else { return }
        guard let index = index else { return }
        let item = viewModel.inputSearchData.value[index]
        
        let itemAlreadySaved = PhotoRepository.shared.fetch().contains { photoRealm in
            photoRealm.imageID == item.id
        }
        
        guard !itemAlreadySaved else { return }
        
        let createdDateText = "\(DateFormatter.dateToContainLetter(dateString: item.createdAt)) 게시됨"
        
        let model = DetailUIModel(
            imageID: item.id,
            profileImage: item.user.profileImage.medium,
            userName: item.user.name,
            createdDate: createdDateText,
            posterImage: item.urls.small,
            sizeInfo: "\(item.width) x \(item.height)",
            viewsInfo: statisticItem.views.total,
            downloadInfo: statisticItem.downloads.total,
            savedTheDate: Date())
        
        guard let viewsInfo = model.viewsInfo, let downloadInfo = model.downloadInfo else { return }
        
        let realmItem = PhotoRealm(
            imageID: model.imageID,
            profileImage: model.profileImage,
            userName: model.userName,
            createdDate: model.createdDate,
            posterImage: model.posterImage,
            sizeInfo: model.sizeInfo,
            viewsInfo: viewsInfo,
            downloadInfo: downloadInfo,
            savedTheDate: model.savedTheDate)
        
        // Realm 저장
        PhotoRepository.shared.add(item: realmItem)
        
        // FileManager 저장
        let indexItem = IndexPath(item: index, section: 0)
        if let cell = searchPhotoView.collectionView.cellForItem(at: indexItem) as? SearchPhotoCell,
           // posterImage
           let image = cell.posterImage.image {
            saveImageToDocumentDirectory(directoryType: .poster, imageName: model.imageID, image: image)
            // profileImage
            fetchImage(from: model.profileImage) { image in
                if let image = image {
                    self.saveImageToDocumentDirectory(directoryType: .profile, imageName: model.imageID, image: image)
                }
            }
        }
        
        showToast(message: "좋아요 목록에 추가되었습니다! :)")
    }
    
    private func dismissKeyboard() {
        searchPhotoView.searchBar.resignFirstResponder()
    }
    
    // MARK: Actions
    @objc func sortButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            viewModel.inputCurrentSortType.value = .latest
        } else {
            viewModel.inputCurrentSortType.value = .relevant
        }
        
        self.searchPhotoView.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        liked = sender.isSelected
        
        let item = viewModel.inputSearchData.value[sender.tag]
        
        if sender.isSelected {
            index = sender.tag
            viewModel.statisticCallRequest(imageID: item.id)
        } else {
            // 좋아요 목록(realm)에서 삭제
            let matchItem = PhotoRepository.shared.fetch().first {
                $0.imageID == item.id
            }
            
            if let matchItem = matchItem {
                PhotoRepository.shared.delete(item: matchItem)
                deleteImageFromDucumentDirectory(directoryType: .poster, imageName: item.id)
                deleteImageFromDucumentDirectory(directoryType: .profile, imageName: item.id)
                showToast(message: "좋아요 목록에서 삭제되었습니다! :)")
            }
        }
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

// MARK: UICollectionViewDataSource
extension SearchPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.inputSearchData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCell.id, for: indexPath) as? SearchPhotoCell else { return UICollectionViewCell() }
        let item = viewModel.inputSearchData.value[indexPath.item]
        cell.configureCell(item: item)
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.likeButton.tag = indexPath.item
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SearchPhotoViewController: UICollectionViewDelegateFlowLayout {
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
extension SearchPhotoViewController: UICollectionViewDelegate { 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.inputSearchData.value[indexPath.item]
        
        let vc = DetailViewController()
        vc.searchViewModel = viewModel
        
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
