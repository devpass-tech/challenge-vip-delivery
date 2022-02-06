import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantDetailConfiguratorTests: XCTestCase {
    private let sut = RestaurantDetailsConfigurator.self

    func test_result_shouldReturnViewController_withRightDependencies() throws {
        let viewController = sut.make(with: .init(restaurantId: "Foo"))

        let viewControllerMirror = Mirror(reflecting: viewController)
        let view = try XCTUnwrap(viewControllerMirror.children.lazy.compactMap { $0.value as? RestaurantDetailsView }.first)
        let interactor = try XCTUnwrap(viewControllerMirror.children.lazy.compactMap { $0.value as? RestaurantDetailsInteractor }.first)
        let router = try XCTUnwrap(viewControllerMirror.children.lazy.compactMap { $0.value as? RestaurantDetailsRouter }.first)

        let interactorMirror = Mirror(reflecting: interactor)
        let presenter = try XCTUnwrap(interactorMirror.children.lazy.compactMap { $0.value as? RestaurantDetailsPresenter }.first)

        XCTAssertNotNil(viewController as? RestaurantDetailsViewController)
        XCTAssertTrue(view.delegate === viewController)
        XCTAssertTrue(router.viewController === viewController)
        XCTAssertTrue(router.dataStore === interactor)
        XCTAssertTrue(presenter.viewController === viewController)
    }
}
