import UIKit
import XCTest
@testable import DeliveryAppChallenge

final class DevPassRouterTests: XCTestCase {
    private let navigationControllerSpy = NavigationControllerSpy()
    private lazy var viewControllerDummy = ViewControllerDummy(navigationControllerSpy: navigationControllerSpy)

    private lazy var sut: DevPassRouter = {
        let router = DevPassRouter()
        router.viewController = viewControllerDummy
        return router
    }()

    func test_routeToNextModule_shouldCallPushViewControllerFromNavigation_andShouldCallHomeViewController_withAnimatedTrue() {
        sut.routeToNextModule()

        XCTAssertTrue(navigationControllerSpy.pushViewControllerCalled)
        XCTAssertNotNil(navigationControllerSpy.pushViewControllerViewControllerPassed as? HomeViewController)
        XCTAssertTrue(navigationControllerSpy.pushViewControllerAnimatedPassed == true)
    }
}

final class NavigationControllerSpy: UINavigationController {

    private(set) var pushViewControllerCalled = false
    private(set) var pushViewControllerViewControllerPassed: UIViewController?
    private(set) var pushViewControllerAnimatedPassed: Bool?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushViewControllerViewControllerPassed = viewController
        pushViewControllerAnimatedPassed = animated
    }
}

final class ViewControllerDummy: UIViewController {

    private let navigationControllerSpy: UINavigationController

    override var navigationController: UINavigationController? {
        navigationControllerSpy
    }

    init(navigationControllerSpy: UINavigationController) {
        self.navigationControllerSpy = navigationControllerSpy
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
