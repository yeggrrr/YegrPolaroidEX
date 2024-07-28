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
    
    func showToast(message : String) {
        let toastLabel = UILabel(
            frame: CGRect(x: self.view.frame.size.width / 2 - 160,
                          y: self.view.frame.size.height - 100,
                          width: 320,
                          height: 40))
        
        toastLabel.backgroundColor = UIColor.customPoint.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.2, options: .curveLinear, animations: {
            toastLabel.alpha = 0.0
        }, completion: { isCompleted in
            toastLabel.removeFromSuperview()
        })
    }
}
