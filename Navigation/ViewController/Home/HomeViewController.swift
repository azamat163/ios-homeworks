//
//  HomeViewController.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    func setupVCs() {
        let feedStoryboard = UIStoryboard(storyboard: .feed)
        let feedVc: FeedViewController = feedStoryboard.instantiateViewController()
        
        let profileStoryboard = UIStoryboard(storyboard: .profile)
        let profileVc: ProfileViewController = profileStoryboard.instantiateViewController()

        viewControllers = [
            createNavController(for: feedVc, title: NSLocalizedString("Feed", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: profileVc, title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
