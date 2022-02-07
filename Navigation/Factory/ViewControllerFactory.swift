//
//  ViewControllerFactory.swift
//  Navigation
//
//  Created by Азамат Агатаев on 30.01.2022.
//

import Foundation
import UIKit

enum TypeOfViewController {
    case home
    case feed(viewModel: FeedViewModel)
    case login(viewModel: LoginViewModel)
    case profile(service: UserService, name: String)
    case postView(title: String)
    case infoView
    case photosView
}

extension TypeOfViewController {
    func makeViewController() -> UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .feed(let viewModel):
            return FeedViewController(viewModel: viewModel)
        case .login(let viewModel):
            return LogInViewController(viewModel: viewModel)
        case .profile(let service, let name):
            return ProfileViewController(service: service, fullName: name)
        case .postView(let title):
            return PostViewController(postTitle: title)
        case .infoView:
            return InfoViewController()
        case .photosView:
            return PhotosViewController()
        }
    }
}

protocol ViewControllerFactoryProtocol {
    func viewController(for typeOfVc: TypeOfViewController) -> UIViewController
}

final class ViewControllerFactory: ViewControllerFactoryProtocol  {
    func viewController(for typeOfVc: TypeOfViewController) -> UIViewController {
        return typeOfVc.makeViewController()
    }
}
