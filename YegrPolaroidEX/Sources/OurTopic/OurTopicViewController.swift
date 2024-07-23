//
//  OurTopicViewController.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import UIKit

final class OurTopicViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "OUR TOPIC"
        
        print(UserDefaultsManager.fetchSourceOfEnergy())
        print(UserDefaultsManager.fetchProcessingOfInfo())
        print(UserDefaultsManager.fetchDecisionMaking())
        print(UserDefaultsManager.fetchNeedForStructure())
    }
}
