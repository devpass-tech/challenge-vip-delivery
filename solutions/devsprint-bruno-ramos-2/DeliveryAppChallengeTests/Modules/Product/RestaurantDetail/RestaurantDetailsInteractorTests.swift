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

    func test_requestFetchRestaurantMenu_whenWorkerReturnsSuccess_shouldCallPresenterWithSuccessName() {
        // Given or Arrange
        let expectedName = "DevPass"
        workerStub.fetchDataCompletionToBeExecuted = .success(expectedName)

        // When or Act
        sut.requestFetchRestaurantMenu(request: .init())

        // Then or Assert
        XCTAssertTrue(workerStub.fetchDataCalled)
        XCTAssertTrue(presenterSpy.presentRestaurantMenuCalled)

        switch presenterSpy.presentRestaurantMenuResponsePassed {
        case .success(let name):
            XCTAssertEqual(name, expectedName)
        default:
            XCTFail("Should be a success result")

        }
    }

    func test_requestFetchRestaurantMenu_whenWorkerReturnsFailure_shouldCallPresenterWithFailureError() {
        // Given or Arrange
        workerStub.fetchDataCompletionToBeExecuted = .failure(ErrorDummy())

        // When or Act
        sut.requestFetchRestaurantMenu(request: .init())

        // Then or Assert
        XCTAssertTrue(workerStub.fetchDataCalled)
        XCTAssertTrue(presenterSpy.presentRestaurantMenuCalled)

        switch presenterSpy.presentRestaurantMenuResponsePassed {
        case .failure(let error):
            XCTAssertNotNil(error)
        default:
            XCTFail("Should be a failure result")

        }
    }
}

struct ErrorDummy: Error { }
