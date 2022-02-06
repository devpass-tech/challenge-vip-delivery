import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantDetailsViewControllerTests: XCTestCase {
    private let viewSpy = RestaurantDetailsViewProtocolSpy()
    private let interactorSpy = RestaurantDetailsBusinessLogicSpy()
    private let routerSpy = RestaurantDetailsRoutingLogicSpy()

    private lazy var sut = RestaurantDetailsViewController(
        customView: viewSpy,
        interactor: interactorSpy,
        router: routerSpy
    )

    func test_viewDidLoad_whenViewDidLoadIsCalled_shouldCallFetchRestaurantMenuPassingRequest() {
        // Given or Arrange
        // --

        // When or Act
        sut.viewDidLoad()


        // Then or Assert
        XCTAssertTrue(interactorSpy.requestFetchRestaurantMenuCalled)
        XCTAssertNotNil(interactorSpy.requestFetchRestaurantMenuRequestPassed)
    }

    func test_displayRestaurantMenu_() throws {
        // Given or Arrange
        let expectedName = "Bar"

        // When or Act
        sut.displayRestaurantMenu(viewModel: .init(name: expectedName))

        // Then or Assert
        XCTAssertTrue(viewSpy.displayCalled)

        let viewModel = try XCTUnwrap(viewSpy.displayViewModelPassed)
        XCTAssertEqual(viewModel.name, expectedName)
    }

}
