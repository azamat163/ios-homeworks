//
//  ProfileTests.swift
//  NavigationTests
//
//  Created by a.agataev on 01.08.2022.
//

import XCTest
@testable import Navigation

class ProfileTests: XCTestCase {
    var navigationController: UINavigationController!
    var viewControllerFactory: ViewControllerFactoryProtocol!
    var profileCoordinator: ProfileCoordinatorMock!
    var profileCoordinatorFlow: ProfileCoordinatorFlowMock!

    override func setUpWithError() throws {
        navigationController = UINavigationController()
        viewControllerFactory = ViewControllerFactory()
        profileCoordinator = ProfileCoordinatorMock(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        profileCoordinatorFlow = ProfileCoordinatorFlowMock(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
    }

    override func tearDownWithError() throws {
        navigationController = nil
        viewControllerFactory = nil
        profileCoordinator = nil
        profileCoordinatorFlow = nil
    }

    func testShowPhotosVc() throws {
        profileCoordinator.start()
        profileCoordinatorFlow.showPhotosVc()
        
        XCTAssertEqual(profileCoordinatorFlow.expectedShowPhotosVc, 1)
    }
    
    func testShowLoginVc() throws {
        profileCoordinator.start()
        profileCoordinatorFlow.showLoginVc()
        
        XCTAssertEqual(profileCoordinatorFlow.expectedShowLoginVc, 1)
    }

}

final class ProfileCoordinatorFlowMock: ProfileCoordinatorFlowProtocol {
    var navigationController: UINavigationController
    var viewControllerFactory: ViewControllerFactoryProtocol
    
    required init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    var expectedShowPhotosVc = 0
    
    func showPhotosVc() {
        expectedShowPhotosVc += 1
    }
    
    var expectedShowLoginVc = 0

    func showLoginVc() {
        expectedShowLoginVc += 1
    }
}

final class ProfileCoordinatorMock: ProfileCoordinator {
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllerFactoryProtocol
    
    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
        super.init(
            navigationController: navigationController,
            fullName: "Test",
            service: TestUserService(),
            viewControllerFactory: viewControllerFactory
        )
    }
}
