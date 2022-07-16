//
//  MapCoordinator.swift
//  Navigation
//
//  Created by a.agataev on 04.07.2022.
//

import Foundation
import UIKit

final class MapCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let viewController = viewControllerFactory.viewController(for: .map)
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
