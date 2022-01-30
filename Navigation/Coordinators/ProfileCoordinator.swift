//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 30.01.2022.
//

import Foundation
import UIKit

final class ProfileCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let fullName: String
    private let service: UserService
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, fullName: String, service: UserService, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.fullName = fullName
        self.service = service
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let profileVc = viewControllerFactory.viewController(for: .profile(service: service, name: fullName)) as! ProfileViewController
        profileVc.showPhotosVc = showPhotosVc
        navigationController?.pushViewController(profileVc, animated: true)
    }
    
    func showPhotosVc() {
        guard let navigationController = navigationController else { return }

        let photosViewCoordinator = PhotosViewCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        photosViewCoordinator.start()
    }
}
