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
    var detailData: TopicData?
    var statisticData: StatisticsData?
    
    // MARK: View Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        // tabBar
        tabBarController?.tabBar.isHidden = true
        
        // data
        guard let detailData = detailData else { 
            print("detailData 안넘어옴")
            return }
        let createDate = DateFormatter.dateToContainLetter(dateString: detailData.createdAt)
        let imageURL = URL(string: detailData.urls.raw)
        let profileURL = URL(string: detailData.user.profileImage.medium)
        
        detailView.posterImage.kf.setImage(with: imageURL)
        detailView.profileImage.kf.setImage(with: profileURL)
        detailView.userNameLabel.text = detailData.user.name
        detailView.createdDateLabel.text = "\(createDate) 게시됨"
        detailView.sizeInfoLabel.text = "\(detailData.width) x \(detailData.height)"
        
        if let statisticData = statisticData {
            print("statisticData 넘어옴")
            detailView.viewsInfoLabel.text = "\(statisticData.views.total.formatted())"
        }
        
        /*
         viewsInfoLabel.text = "1,548,623" -> formatter 사용하기
         downloadInfoLabel.text = "388,996"
         */
    }
}
