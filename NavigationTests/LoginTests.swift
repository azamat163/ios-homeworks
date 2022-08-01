//
//  LoginTests.swift
//  NavigationTests
//
//  Created by a.agataev on 11.10.2021.
//

import XCTest
import UIKit
@testable import Navigation

class LoginTests: XCTestCase {
    var navigationController: UINavigationController!
    var viewControllerFactory: ViewControllerFactoryProtocol!
    var loginCoordinator: LogInCoordinatorMock!
    var loginCoordinatorFlow: LogInCoordinatorFlowMock!


    override func setUpWithError() throws {
        try super.setUpWithError()
        
        navigationController = UINavigationController()
        viewControllerFactory = ViewControllerFactory()
        loginCoordinator = LogInCoordinatorMock(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        loginCoordinatorFlow = LogInCoordinatorFlowMock(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
    }

    override func tearDownWithError() throws {
        viewControllerFactory = nil
        navigationController = nil
        loginCoordinator = nil
        loginCoordinatorFlow = nil
        
        try super.tearDownWithError()
    }

    func testLogin() throws {
        loginCoordinator.start()
        loginCoordinatorFlow.showProfileVc(fullName: "Test")
        XCTAssertEqual(loginCoordinatorFlow.showProfileVcCalls, 1)
        XCTAssertEqual(loginCoordinatorFlow.expectedName, "Test")
    }
}

final class LogInCoordinatorFlowMock: LogInCoordinatorFlowProtocol {
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllerFactoryProtocol
    
    required init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    var showProfileVcCalls: Int = 0
    var expectedName: String = ""
    func showProfileVc(fullName: String) {
        showProfileVcCalls += 1
        expectedName = fullName
    }
}

final class LogInCoordinatorMock: LogInCoordinator {}
