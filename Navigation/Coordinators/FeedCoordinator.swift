//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 25.01.2022.
//

import Foundation
import UIKit

final class FeedCoordinator: Coordinator {
    var onFinish: (() -> Void)?
    
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol

    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let viewModel = FeedViewModel()
        let viewController = viewControllerFactory.viewController(for: .feed(viewModel: viewModel)) as! FeedViewController
        viewModel.showPostVc = showPostVc(title:)
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func showPostVc(title: String) {
        guard let navigationController = navigationController else { return }
        
        let postViewCoordinator = PostViewCoordinator(navigationController: navigationController, title: title, viewControllerFactory: viewControllerFactory)
        postViewCoordinator.start()
    }
}
