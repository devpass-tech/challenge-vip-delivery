import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantDetailsInteractorTests: XCTestCase {
    private let presenterSpy = RestaurantDetailsPresentationLogicSpy()
    private let workerStub = RestaurantDetailsWorkingStub()

    private lazy var sut = RestaurantDetailsInteractor(
        presenter: presenterSpy,
        worker: workerStub
    )

    func test_requestFetchRestaurantMenu_whenWorkerReturnsSuccess_shouldCallPresenterWithSuccessResult() {
        // Given or Arrange
        workerStub.fetchDataCompletionToBeExecuted = .success(.fixture(name: "Padaria do João"))
        
        // When or Act
        sut.requestFetchRestaurantMenu(request: .init())

        // Then or Assert
        XCTAssertTrue(workerStub.fetchDataCalled)
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
        workerStub.fetchDataCompletionToBeExecuted = .failure(.networkError)

        // When or Act
        sut.requestFetchRestaurantMenu(request: .init())

        // Then or Assert
        XCTAssertTrue(workerStub.fetchDataCalled)
        XCTAssertTrue(presenterSpy.presentRestaurantMenuCalled)

        switch presenterSpy.presentRestaurantMenuResponsePassed {
        case .failure(let error):
            XCTAssertNotNil(error as APIError)
            XCTAssertEqual(error, APIError.networkError)
            XCTAssertNotEqual(error, APIError.invalidURL)
        default:
            XCTFail("Should be a failure result")

        }
    }
}
