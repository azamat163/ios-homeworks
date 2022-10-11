//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 30.01.2022.
//

import Foundation
import UIKit

protocol ProfileCoordinatorFlowProtocol {
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllerFactoryProtocol { get }
    
    func showPhotosVc()
    func showLoginVc()
}

class ProfileCoordinatorFlow: ProfileCoordinatorFlowProtocol {
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllerFactoryProtocol
    
    private let myLoginFactory = MyLoginFactory()
    
    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func showPhotosVc() {
        let photosViewCoordinator = PhotosViewCoordinator(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        photosViewCoordinator.start()
    }
    
    func showLoginVc() {
        let loginInspector = myLoginFactory.makeLoginInspector()
        loginInspector.signOut()
        let logInCoordinator = LogInCoordinator(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        logInCoordinator.start()
    }
}

class ProfileCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let fullName: String
    private let service: UserService
    private let viewControllerFactory: ViewControllerFactoryProtocol
    private let profileCoordinatorFlow: ProfileCoordinatorFlow
    
    init(
        navigationController: UINavigationController,
        fullName: String, service: UserService,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.fullName = fullName
        self.service = service
        self.viewControllerFactory = viewControllerFactory
        self.profileCoordinatorFlow = ProfileCoordinatorFlow(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
    }
    
    func start() {
        let viewModel = ProfileViewModel()
        let profileVc = viewControllerFactory.viewController(
            for: .profile(
                viewModel: viewModel,
                service: service,
                name: fullName
            )
        ) as! ProfileViewController
        viewModel.showPhotosVc = profileCoordinatorFlow.showPhotosVc
        viewModel.showLoginVc = profileCoordinatorFlow.showLoginVc
        navigationController?.setViewControllers([profileVc], animated: false)
    }
}
