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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: FeedViewController(), title: NSLocalizedString(Constants.feedTitle, comment: ""), image: UIImage(systemName: Constants.feedImageName)!),
            createNavController(for: ProfileViewController(), title: NSLocalizedString(Constants.profileTitle, comment: ""), image: UIImage(systemName: Constants.profileImageName)!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
}
