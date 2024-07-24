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
        ourTopicNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tap_trend_inactive"), selectedImage: UIImage(named: "tab_trend"))
        
        let searchPhotoVC = SearchPhotoViewController()
        let searchPhotoNav = UINavigationController(rootViewController: searchPhotoVC)
        ourTopicNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab_search_inactive"), selectedImage: UIImage(named: "tab_search"))
        
        
        let likePhotoVC = LikePhotoViewController()
        let likePhotoNav = UINavigationController(rootViewController: likePhotoVC)
        ourTopicNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab_like_inactive"), selectedImage: UIImage(named: "tab_like"))
        
        setViewControllers([ourTopicNav, searchPhotoNav, likePhotoNav], animated: true)
    }
}
