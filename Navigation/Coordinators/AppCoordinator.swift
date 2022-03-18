//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 24.01.2022.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator, Coordinator {
    private let viewControllerFactory: ViewControllerFactoryProtocol
    private let tabBarController = HomeViewController()
    private var window: UIWindow?
    private let scene: UIWindowScene
    
    private enum Constants {
        static let feedTitle: String = "Feed"
        static let profileTitle: String = "Profile"
        static let feedImageName: String = "house"
        static let profileImageName: String = "person"
        static let mainColor: UIColor = UIColor(named: "Color") ?? .label
    }

    init(scene: UIWindowScene, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.scene = scene
        self.viewControllerFactory = viewControllerFactory
        super.init()
    }

    func start() {
        initWindow()
        initTabBarController()
    }

    private func initWindow() {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func initTabBarController() {
        tabBarController.viewControllers = settingsViewControllers()
    }
    
    private func settingsViewControllers() -> [UIViewController] {
        let feedViewModel = FeedViewModel()
        let feedVc = viewControllerFactory.viewController(for: .feed(viewModel: feedViewModel))
        let navFeedVc = createNavController(for: feedVc, title: NSLocalizedString(Constants.feedTitle, comment: ""), image: UIImage(systemName: Constants.feedImageName)!)
        let feedCoordinator = FeedCoordinator(navigationController: navFeedVc, viewControllerFactory: viewControllerFactory)
        
        let loginViewModel = LoginViewModel()
        let logInVc = viewControllerFactory.viewController(for: .login(viewModel: loginViewModel))
        let navLogInVc = createNavController(for: logInVc, title: NSLocalizedString(Constants.profileTitle, comment: ""), image: UIImage(systemName: Constants.profileImageName)!)
        let logInCoordinator = LogInCoordinator(navigationController: navLogInVc, viewControllerFactory: viewControllerFactory)
        
        addDependency(feedCoordinator)
        addDependency(logInCoordinator)
        
        feedCoordinator.start()
        logInCoordinator.start()
        
        return [
            navFeedVc,
            navLogInVc
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = image.withTintColor(Constants.mainColor, renderingMode: .alwaysOriginal)
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        
        return navController
    }
}
