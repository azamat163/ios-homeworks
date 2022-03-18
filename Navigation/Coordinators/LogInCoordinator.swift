//
//  LogInCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 25.01.2022.
//

import Foundation
import UIKit

final class LogInCoordinator: Coordinator {
    private let myLoginFactory = MyLoginFactory()
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let viewModel = LoginViewModel()
        let viewController = viewControllerFactory.viewController(for: .login(viewModel: viewModel)) as! LogInViewController
        viewController.delegate = myLoginFactory.makeLoginInspector()
        viewModel.showProfileVc = showProfileVc(fullName:)
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func showProfileVc(fullName: String) {
        guard let navigationController = navigationController else { return }

        var currentUser: UserService
        
        #if DEBUG
            currentUser = TestUserService()
        #else
           let user = User(
            fullName: fullName,
            avatar: "avatar_cat",
            status: "Waiting for something..."
           )
           currentUser = CurrentService(user: user)
        #endif
        let profileCoordinator = ProfileCoordinator(
            navigationController: navigationController,
            fullName: fullName,
            service: currentUser,
            viewControllerFactory: viewControllerFactory
        )
        profileCoordinator.start()
    }
}
