//
//  PostFavoritesCoordinator.swift
//  Navigation
//
//  Created by a.agataev on 25.05.2022.
//

import Foundation
import UIKit

class PostFavoritesCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let viewController = viewControllerFactory.viewController(for: .postFavorites(viewModel: PostFavoritesViewModel())) as! PostFavoritesViewController
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
