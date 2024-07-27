//
//  DetailViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/25/24.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    // MARK: UI
    let detailView = DetailView()
    
    // MARK: Properties
    var detailUIModel: DetailUIModel?
    var ourTopicViewModel: OurTopicViewModel?
    var searchViewModel: SearchViewModel?
    
    // MARK: View Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        statisticAPICall()
        configureUI()
    }
    
    func bindData() {
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
    
    func configureUI() {
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
    }
    
    func statisticAPICall() {
        guard let model = detailUIModel else { return }
        
        if let ourTopicViewModel {
            ourTopicViewModel.statisticCallRequest(imageID: model.imageID)
        }
        
        if let searchViewModel {
            searchViewModel.statisticCallRequest(imageID: model.imageID)
        }
    }
}
