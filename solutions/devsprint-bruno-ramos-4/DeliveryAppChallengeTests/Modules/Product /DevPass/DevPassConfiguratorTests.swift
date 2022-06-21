import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class DevPassConfiguratorTests: XCTestCase {
    func test_make_shouldCreateDevPassViewController_withCorrectObjectInjections() throws {
        let viewController = DevPassConfigurator.make()
        let viewControllerMirrored = Mirror(reflecting: viewController)

        let interactor = try XCTUnwrap(viewControllerMirrored.children.lazy.compactMap { $0.value as? DevPassInteractor }.first)
        let interactorMirrored = Mirror(reflecting: interactor)

        let presenter = try XCTUnwrap(interactorMirrored.children.lazy.compactMap { $0.value as? DevPassPresenter }.first)
        let presenterMirrored = Mirror(reflecting: presenter)

        XCTAssertNotNil(presenterMirrored.children.lazy.compactMap { $0.value as? DevPassViewController })

        let router = try XCTUnwrap(viewControllerMirrored.children.lazy.compactMap { $0.value as? DevPassRouter }.first)
        let routerMirrored = Mirror(reflecting: router)

        XCTAssertNotNil(routerMirrored.children.lazy.compactMap { $0.value as? DevPassViewController })

        let view = try XCTUnwrap(viewControllerMirrored.children.lazy.compactMap { $0.value as? DevPassView }.first)
        let viewMirrored = Mirror(reflecting: view)

        XCTAssertNotNil(viewMirrored.children.lazy.compactMap { $0.value as? DevPassViewController })

        XCTAssertNotNil(viewController as? DevPassViewController)
    }
}
