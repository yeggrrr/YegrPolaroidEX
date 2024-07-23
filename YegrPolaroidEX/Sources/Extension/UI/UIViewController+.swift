//
//  UIViewController+.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/23/24.
//

import UIKit

extension UIViewController {
    func screenTransition(_ vc: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let sceneDelegate = scene.delegate as? SceneDelegate else { return }
        
        if vc is UITabBarController {
            sceneDelegate.window?.rootViewController = vc
        } else {
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: vc)
        }
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
