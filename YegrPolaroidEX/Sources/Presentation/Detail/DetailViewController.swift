//
//  DetailViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/25/24.
//

import UIKit
import Kingfisher
import Toast

final class DetailViewController: UIViewController {
    // MARK: Enum
    enum ViewType {
        case topicTab
        case searchTab
        case likeTab
    }
    
    // MARK: UI
    private let detailView = DetailView()
    
    // MARK: Properties
    var detailUIModel: DetailUIModel?
    var ourTopicViewModel: OurTopicViewModel?
    var searchViewModel: SearchViewModel?
    var realmLikeModel: PhotoRealm?
    var index: Int?
    var liked: Bool?
    
    var viewType: ViewType = .topicTab
    
    // MARK: View Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoRepository.shared.findFilePath() // TODO: 나중에 지우기
        configureUI()
        configureAction()
        
        switch viewType {
        case .topicTab:
            liked = false
            bindData()
            statisticAPICall()
        case .searchTab:
            liked = true
            bindData()
            statisticAPICall()
        case .likeTab:
            liked = true
            likeTabSetupUI()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if liked == false {
            delete()
        }
    }
    
    // MARK: Functions
    private func bindData() {
        if let topicViewModel = ourTopicViewModel {
            topicViewModel.inputStatisticData.bind { value in
                guard let value = value else { return }
                self.detailUIModel?.viewsInfo = value.views.total
                self.detailUIModel?.downloadInfo = value.downloads.total
                self.configureUI()
            }
        } else if let searchViewModel = searchViewModel {
            searchViewModel.inputStatisticData.bind { value in
                guard let value = value else { return }
                self.detailUIModel?.viewsInfo = value.views.total
                self.detailUIModel?.downloadInfo = value.downloads.total
                self.configureUI()
            }
        }
    }
    
    private func configureUI() {
        // tabBar
        tabBarController?.tabBar.isHidden = true
        
        // data
        guard let model = detailUIModel else { return }
        
        let imageURL = URL(string: model.posterImage)
        let profileURL = URL(string: model.profileImage)
        detailView.posterImage.kf.setImage(with: imageURL)
        detailView.profileImage.kf.setImage(with: profileURL)
        
        detailView.userNameLabel.text = model.userName
        detailView.createdDateLabel.text = model.createdDate
        detailView.sizeInfoLabel.text = model.sizeInfo
        
        detailView.viewsInfoLabel.text = model.viewsInfo?.formatted()
        detailView.downloadInfoLabel.text = model.downloadInfo?.formatted()
        
        if  PhotoRepository.shared.fetch().contains(where: { photoRealm in
            photoRealm.imageID == model.imageID
        }) {
            detailView.likeButton.isSelected = true
        } else {
            detailView.likeButton.isSelected = false
        }
    }
    
    private func likeTabSetupUI() {
        guard let realmLikeModel = realmLikeModel else { return }
        detailView.posterImage.image = loadImageFromDocumentDirectory(directoryType: .poster, imageName: realmLikeModel.imageID)
        detailView.profileImage.image = loadImageFromDocumentDirectory(directoryType: .profile, imageName: realmLikeModel.imageID)
        
        detailView.userNameLabel.text = realmLikeModel.userName
        detailView.createdDateLabel.text = realmLikeModel.createdDate
        detailView.sizeInfoLabel.text = realmLikeModel.sizeInfo
        
        detailView.viewsInfoLabel.text = realmLikeModel.viewsInfo.formatted()
        detailView.downloadInfoLabel.text = realmLikeModel.downloadInfo.formatted()
        
        detailView.likeButton.isSelected = true
    }
    
    private func statisticAPICall() {
        guard let model = detailUIModel else { return }
        if let ourTopicViewModel {
            ourTopicViewModel.statisticCallRequest(imageID: model.imageID)
        }
        
        if let searchViewModel {
            searchViewModel.statisticCallRequest(imageID: model.imageID)
        }
    }
    
    private func configureAction() {
        detailView.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc func likeButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        liked = sender.isSelected
        
        guard let model = detailUIModel else { return }
    
        if sender.isSelected {
            guard let viewsInfo = model.viewsInfo, let downloadInfo = model.downloadInfo else { return }
            
            let itemAlreadySaved = PhotoRepository.shared.fetch().contains { photoRealm in
                photoRealm.imageID == model.imageID
            }
            
            guard !itemAlreadySaved else { return }
            
            // Realm 저장
            let item = PhotoRealm(
                imageID: model.imageID,
                profileImage: model.profileImage,
                userName: model.userName,
                createdDate: model.createdDate,
                posterImage: model.posterImage,
                sizeInfo: model.sizeInfo,
                viewsInfo: viewsInfo,
                downloadInfo: downloadInfo,
                savedTheDate: Date())
            PhotoRepository.shared.add(item: item)
            
            // FileManager 저장
            if let posterImage = detailView.posterImage.image {
                saveImageToDocumentDirectory(directoryType: .poster, imageName: model.imageID, image: posterImage)
            }
            
            if let profileImage = detailView.profileImage.image {
                saveImageToDocumentDirectory(directoryType: .profile, imageName: model.imageID, image: profileImage)
            }
            
            showToast(message: "좋아요 목록에 추가되었습니다! :)")
        } else {
            switch viewType {
            case .topicTab, .searchTab:
                let matchedItem = PhotoRepository.shared.fetch().first { photoRealm in
                    photoRealm.imageID == model.imageID
                }
                
                if let matchedItem = matchedItem {
                    deleteImageFromDucumentDirectory(directoryType: .poster, imageName: model.imageID)
                    deleteImageFromDucumentDirectory(directoryType: .profile, imageName: model.imageID)
                    PhotoRepository.shared.delete(item: matchedItem)
                }
                showToast(message: "좋아요 목록에서 삭제되었습니다! :)")
            case .likeTab:
                showToast(message: "좋아요 목록에서 삭제되었습니다! :)")
            }
        }
    }
    
    func delete() {
        guard let index = index else { return }
        let item = PhotoRepository.shared.fetch()[index]
        let imageID = item.imageID
        
        // Realm 삭제
        PhotoRepository.shared.delete(item: item)
        
        // FileManager 삭제
        deleteImageFromDucumentDirectory(directoryType: .poster, imageName: imageID)
        deleteImageFromDucumentDirectory(directoryType: .profile, imageName: imageID)
        showToast(message: "좋아요 목록에서 삭제되었습니다! :)")
    }
}
