//
//  RestaurantListRouterTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Gustavo Tiecker on 07/02/22.
//

import XCTest

@testable import DeliveryAppChallenge

class RestaurantListRouterTests: XCTestCase {
    
    let navigationControllerSpy = NavigationControllerSpy()
    lazy var viewControllerSpy = UIViewControllerSpy(navigationController: navigationControllerSpy)
    
    lazy var sut: RestaurantListRouter = {
        let router = RestaurantListRouter()
        router.viewController = viewControllerSpy
        return router
    }()
    
    func test_() {
        // When
        sut.routeToRestaurantDetail()
        
        // Then
        XCTAssertTrue(navigationControllerSpy.pushViewControllerCalled)
        XCTAssertNotNil(navigationControllerSpy.viewControllerPassed as? RestaurantDetailsViewController)
    }
}

class NavigationControllerSpy: UINavigationController {
    
    private (set) var pushViewControllerCalled: Bool = false
    private (set) var viewControllerPassed: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        viewControllerPassed = viewController
    }
}

class UIViewControllerSpy: UIViewController {
    
    private let navigationControllerDummy: UINavigationController
    override var navigationController: UINavigationController? {
        navigationControllerDummy
    }
    
    init(navigationController: UINavigationController) {
        navigationControllerDummy = navigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
