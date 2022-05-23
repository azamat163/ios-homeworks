//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 24.01.2022.
//

import Foundation
import UIKit
import FirebaseAuth

final class AppCoordinator: BaseCoordinator, Coordinator {
    private let viewControllerFactory: ViewControllerFactoryProtocol
    private let tabBarController = HomeViewController()
    private var window: UIWindow?
    private let scene: UIWindowScene
    
    private enum Constants {
        static let feedTitle: String = "Feed"
        static let profileTitle: String = "Profile"
        static let audioTitle: String = "Listen Now"
        static let feedImageName: String = "house"
        static let profileImageName: String = "person"
        static let audioImageName: String = "play.circle.fill"
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
        let ud = UserDefaults.standard
        let feedViewModel = FeedViewModel()
        let feedVc = viewControllerFactory.viewController(for: .feed(viewModel: feedViewModel))
        let navFeedVc = createNavController(for: feedVc, title: NSLocalizedString(Constants.feedTitle, comment: ""), image: UIImage(systemName: Constants.feedImageName)!)
        let feedCoordinator = FeedCoordinator(navigationController: navFeedVc, viewControllerFactory: viewControllerFactory)
        
        let audiosViewModel = AudiosViewModel(
            audioApi: AudioAPI(),
            videoApi: VideoAPI(),
            service: AudioPlayerService.shared
        )
        let audioVc = viewControllerFactory.viewController(for: .audio(viewModel: audiosViewModel))
        let navAudioVc = createNavController(for: audioVc, title: Constants.audioTitle, image: UIImage(systemName: Constants.audioImageName)!)
        let audioCoordinator = AudioCoordinator(navigationController: navAudioVc, viewControllerFactory: viewControllerFactory)
        
        addDependency(feedCoordinator)
        addDependency(audioCoordinator)
        
        feedCoordinator.start()
        audioCoordinator.start()
        
        guard let user = Auth.auth().currentUser,
              let userInfo = ud.object(forKey: user.uid) as? [String: String],
              let email = userInfo["email"]
        else {
            let loginViewModel = LoginViewModel()
            let logInVc = viewControllerFactory.viewController(for: .login(viewModel: loginViewModel))
            let navLogInVc = createNavController(for: logInVc, title: NSLocalizedString(Constants.profileTitle, comment: ""), image: UIImage(systemName: Constants.profileImageName)!)
            let logInCoordinator = LogInCoordinator(navigationController: navLogInVc, viewControllerFactory: viewControllerFactory)
            addDependency(logInCoordinator)
            logInCoordinator.start()
            return [
                navFeedVc,
                navLogInVc,
                navAudioVc,
            ]
        }
        
        let profileViewModel = ProfileViewModel()
        let testService = TestUserService()
        testService.user.fullName = email
        let profileVc = viewControllerFactory.viewController(for: .profile(viewModel: profileViewModel, service: testService, name: email)) as! ProfileViewController
        let navProfileInVc = createNavController(for: profileVc, title: NSLocalizedString(Constants.profileTitle, comment: ""), image: UIImage(systemName: Constants.profileImageName)!)
        let profileCoordinator = ProfileCoordinator(navigationController: navProfileInVc, fullName: email, service: testService, viewControllerFactory: viewControllerFactory)
        
        addDependency(profileCoordinator)
        profileCoordinator.start()
        
        return [
            navFeedVc,
            navProfileInVc,
            navAudioVc,
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
