//
//  RecordCoordinator.swift
//  Navigation
//
//  Created by a.agataev on 22.02.2022.
//

import Foundation
import UIKit

class RecordCoordinator: Coordinator {
    private let vc: UIViewController
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(vc: UIViewController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.vc = vc
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let viewController = viewControllerFactory.viewController(for: .record) as! RecordViewController
        vc.present(viewController, animated: true, completion: nil)
    }
}
