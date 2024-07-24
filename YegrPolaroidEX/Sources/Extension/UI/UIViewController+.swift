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
    
    func showAlert(title: String, message: String, completionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: completionHandler)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
}
