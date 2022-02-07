//
//  HomeViewController.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import UIKit

class HomeViewController: UITabBarController {
    
    private enum Constants {
        static let feedTitle: String = "Feed"
        static let profileTitle: String = "Profile"
        static let feedImageName: String = "house"
        static let profileImageName: String = "person"
        static let mainColor: UIColor = UIColor(named: "Color") ?? .label
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = Constants.mainColor
    }
}
