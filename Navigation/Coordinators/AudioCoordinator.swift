//
//  AudioCoordinator.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import Foundation
import UIKit

final class AudioCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let viewModel = AudiosViewModel(
            audioApi: AudioAPI(),
            videoApi: VideoAPI(),
            service: AudioPlayerService.shared
        )
        let viewController = viewControllerFactory.viewController(for: .audio(viewModel: viewModel)) as! AudiosViewController
        viewModel.showRecordVc = showRecordVc(viewController:)
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func showRecordVc(viewController: UIViewController) {
        let recordViewCoordinator = RecordCoordinator(vc: viewController, viewControllerFactory: viewControllerFactory)
        recordViewCoordinator.start()
    }
}
