//
//  LogInCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 25.01.2022.
//

import Foundation
import UIKit

protocol LogInCoordinatorFlowProtocol {
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllerFactoryProtocol { get }
    
    func showProfileVc(fullName: String)
}

class LogInCoordinatorFlow: LogInCoordinatorFlowProtocol {
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func showProfileVc(fullName: String) {
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

class LogInCoordinator: Coordinator {
    private let myLoginFactory = MyLoginFactory()
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    private let logInCoordinatorFlow: LogInCoordinatorFlow
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
        self.logInCoordinatorFlow = LogInCoordinatorFlow(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
    }
    
    func start() {
        let viewModel = LoginViewModel()
        let viewController = viewControllerFactory.viewController(for: .login(viewModel: viewModel)) as! LogInViewController
        viewController.delegate = myLoginFactory.makeLoginInspector()
        viewModel.showProfileVc = logInCoordinatorFlow.showProfileVc(fullName:)
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
