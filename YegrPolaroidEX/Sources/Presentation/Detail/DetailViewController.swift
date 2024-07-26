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
    
    // MARK: View Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        configureUI()
        statisticAPICall()
    }
    
    func bindData() {
        guard let viewModel = ourTopicViewModel else { return }
        viewModel.inputStatisticData.bind { value in
            self.detailUIModel?.viewsInfo = value?.views.total
            self.detailUIModel?.downloadInfo = value?.downloads.total
            self.configureUI()
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
        ourTopicViewModel?.statisticCallRequest(imageID: model.imageID)
    }
}
