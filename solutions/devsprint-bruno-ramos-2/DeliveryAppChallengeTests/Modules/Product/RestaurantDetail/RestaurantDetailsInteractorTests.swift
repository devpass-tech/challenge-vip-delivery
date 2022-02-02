import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantDetailsInteractorTests: XCTestCase {
    private let presenterSpy = RestaurantDetailsPresentationLogicSpy()
    private let getRestaurantDetailsUseCaseSpy = GetRestaurantDetailsUseCaseSpy()

    private lazy var sut = RestaurantDetailsInteractor(
        presenter: presenterSpy,
        getRestaurantDetails: getRestaurantDetailsUseCaseSpy,
        restaurantId: "Foo"
    )

    func test_requestFetchRestaurantMenu_whenWorkerReturnsSuccess_shouldCallPresenterWithSuccessResult() {
        // Given or Arrange
        getRestaurantDetailsUseCaseSpy.executeCompletionToBeExecuted = .success(.fixture(name: "Padaria do João"))
        
        // When or Act
        sut.requestFetchRestaurantMenu(request: .init())

        // Then or Assert
        XCTAssertTrue(getRestaurantDetailsUseCaseSpy.executeCalled)
        XCTAssertTrue(presenterSpy.presentRestaurantMenuCalled)

        switch presenterSpy.presentRestaurantMenuResponsePassed {
        case .success(let restaurantDetails):
            XCTAssertNotNil(restaurantDetails)
            XCTAssertEqual(restaurantDetails.name, "Padaria do João")
            XCTAssertEqual(restaurantDetails.category, "Almoço")
        default:
            XCTFail("Should be a success result")
        }
    }

    func test_requestFetchRestaurantMenu_whenWorkerReturnsFailure_shouldCallPresenterWithFailureError() {
        // Given or Arrange
        let exptectedError = ErrorDummy()
        getRestaurantDetailsUseCaseSpy.executeCompletionToBeExecuted = .failure(exptectedError)

        // When or Act
        sut.requestFetchRestaurantMenu(request: .init())

        // Then or Assert
        XCTAssertTrue(getRestaurantDetailsUseCaseSpy.executeCalled)
        XCTAssertTrue(presenterSpy.presentRestaurantMenuCalled)

        switch presenterSpy.presentRestaurantMenuResponsePassed {
        case .failure(let error):
            XCTAssertNotNil(error as? ErrorDummy)
        default:
            XCTFail("Should be a failure result")

        }
    }
}
