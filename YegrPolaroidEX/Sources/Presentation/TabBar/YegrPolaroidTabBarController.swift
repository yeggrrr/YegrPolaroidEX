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
        tabBar.tintColor = .pointDarkColor
        tabBar.unselectedItemTintColor = .incompleteColor
        
        let ourTopicVC = OurTopicViewController()
        let ourTopicNav = UINavigationController(rootViewController: ourTopicVC)
        ourTopicNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tapTrendInactive"), selectedImage: UIImage(named: "tabTrend"))
        
        let searchPhotoVC = SearchPhotoViewController()
        let searchPhotoNav = UINavigationController(rootViewController: searchPhotoVC)
        searchPhotoNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabSearchInactive"), selectedImage: UIImage(named: "tabSearch"))
        
        
        let likePhotoVC = LikePhotoViewController()
        let likePhotoNav = UINavigationController(rootViewController: likePhotoVC)
        likePhotoNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabLikeInactive"), selectedImage: UIImage(named: "tabLike"))
        
        setViewControllers([ourTopicNav, searchPhotoNav, likePhotoNav], animated: true)
    }
}
