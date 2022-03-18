//
//  InfoViewCoordinator.swift
//  Navigation
//
//  Created by Азамат Агатаев on 30.01.2022.
//

import Foundation
import UIKit

final class InfoViewCoordinator: Coordinator {
    private let postViewController: UIViewController
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(vc: UIViewController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.postViewController = vc
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let infoVc: InfoViewController = viewControllerFactory.viewController(for: .infoView) as! InfoViewController
        postViewController.present(infoVc, animated: true, completion: nil)
    }
}
