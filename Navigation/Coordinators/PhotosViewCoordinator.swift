//
//  PhotosViewCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 30.01.2022.
//

import Foundation
import UIKit

final class PhotosViewCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let photosVc = viewControllerFactory.viewController(for: .photosView)
        navigationController?.pushViewController(photosVc, animated: true)
    }
}
