//
//  AudioCoordinator.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import Foundation
import UIKit

class AudioCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let viewModel = AudioViewModel()
        let viewController = viewControllerFactory.viewController(for: .audio(viewModel: viewModel)) as! AudioViewController
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
