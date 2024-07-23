//
//  YegrPolaroidTabBarController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit

final class YegrPolaroidTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .customPoint
        tabBar.unselectedItemTintColor = .incompleteColor
        
        let ourTopicVC = OurTopicViewController()
        let ourTopicNav = UINavigationController(rootViewController: ourTopicVC)
        ourTopicNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 0)
        
        let searchPhotoVC = SearchPhotoViewController()
        let searchPhotoNav = UINavigationController(rootViewController: searchPhotoVC)
        searchPhotoNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        
        let likePhotoVC = LikePhotoViewController()
        let likePhotoNav = UINavigationController(rootViewController: likePhotoVC)
        likePhotoNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), tag: 2)
        
        setViewControllers([ourTopicNav, searchPhotoNav, likePhotoNav], animated: true)
    }
}
