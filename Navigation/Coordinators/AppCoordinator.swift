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
        static let feedImageName: String = "house"
        static let profileImageName: String = "person"
        static let postFavoritesImageName: String = "heart"
        static let audioImageName: String = "play.circle.fill"
        static let mapImageName: String = "map.circle"
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
        let navFeedVc = createNavController(
            for: feedVc,
            title: String(localized: "tabbar_feed_title"),
            image: UIImage(systemName: Constants.feedImageName)!
        )
        let feedCoordinator = FeedCoordinator(navigationController: navFeedVc, viewControllerFactory: viewControllerFactory)
        
        let audiosViewModel = AudiosViewModel(
            audioApi: AudioAPI(),
            videoApi: VideoAPI(),
            service: AudioPlayerService.shared
        )
        let audioVc = viewControllerFactory.viewController(for: .audio(viewModel: audiosViewModel))
        let navAudioVc = createNavController(
            for: audioVc,
            title: String(localized: "tabbar_audio_title"),
            image: UIImage(systemName: Constants.audioImageName)!
        )
        let audioCoordinator = AudioCoordinator(navigationController: navAudioVc, viewControllerFactory: viewControllerFactory)
        
        let postFavoritesVc = viewControllerFactory.viewController(for: .postFavorites(viewModel: PostFavoritesViewModel()))
        let navPostFavoritesVc = createNavController(
            for: postFavoritesVc,
            title: String(localized: "tabbar_post_favorites_title"),
            image: UIImage(systemName: Constants.postFavoritesImageName)!
        )
        let postFavoritesCoordinator = PostFavoritesCoordinator(navigationController: navPostFavoritesVc, viewControllerFactory: viewControllerFactory)
        
        let mapVc = viewControllerFactory.viewController(for: .map)
        let navMapVc = createNavController(
            for: mapVc, title: NSLocalizedString("tabbar_map_title", comment: ""),
            image: UIImage(systemName: Constants.postFavoritesImageName)!
        )
        let mapCoordinator = MapCoordinator(
            navigationController: navMapVc,
            viewControllerFactory: viewControllerFactory
        )
        
        addDependency(feedCoordinator)
        addDependency(postFavoritesCoordinator)
        addDependency(audioCoordinator)
        addDependency(mapCoordinator)
        
        feedCoordinator.start()
        audioCoordinator.start()
        postFavoritesCoordinator.start()
        mapCoordinator.start()
        
        guard let userInfo = ud.object(forKey: "login_user") as? [String: String],
              let email = userInfo["email"]
        else {
            let loginViewModel = LoginViewModel()
            let logInVc = viewControllerFactory.viewController(for: .login(viewModel: loginViewModel))
            let navLogInVc = createNavController(
                for: logInVc,
                title: String(localized: "tabbar_profile_title"),
                image: UIImage(systemName: Constants.profileImageName)!
            )
            let logInCoordinator = LogInCoordinator(navigationController: navLogInVc, viewControllerFactory: viewControllerFactory)
            addDependency(logInCoordinator)
            logInCoordinator.start()
            return [
                navFeedVc,
                navLogInVc,
                navPostFavoritesVc,
                navAudioVc,
                navMapVc
            ]
        }
        
        let profileViewModel = ProfileViewModel()
        let testService = TestUserService()
        testService.user.fullName = email
        let profileVc = viewControllerFactory.viewController(for: .profile(viewModel: profileViewModel, service: testService, name: email)) as! ProfileViewController
        let navProfileInVc = createNavController(
            for: profileVc,
            title: String(localized: "tabbar_profile_title"),
            image: UIImage(systemName: Constants.profileImageName)!
        )
        let profileCoordinator = ProfileCoordinator(navigationController: navProfileInVc, fullName: email, service: testService, viewControllerFactory: viewControllerFactory)
        
        addDependency(profileCoordinator)
        profileCoordinator.start()
        
        return [
            navFeedVc,
            navProfileInVc,
            navPostFavoritesVc,
            navAudioVc,
            navMapVc
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
