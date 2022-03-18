//
//  PostViewCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 30.01.2022.
//

import Foundation
import UIKit

final class PostViewCoordinator: Coordinator {
    
    private weak var navigationController: UINavigationController?
    private let title: String
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, title: String, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.title = title
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let postViewVc = viewControllerFactory.viewController(for: .postView(title: title)) as! PostViewController
        postViewVc.showInfoVc = showInfoVc(postViewController:)
        navigationController?.pushViewController(postViewVc, animated: true)
    }
    
    func showInfoVc(postViewController: UIViewController) {
        let infoViewCoordinator = InfoViewCoordinator(vc: postViewController, viewControllerFactory: viewControllerFactory)
        infoViewCoordinator.start()
    }
}
