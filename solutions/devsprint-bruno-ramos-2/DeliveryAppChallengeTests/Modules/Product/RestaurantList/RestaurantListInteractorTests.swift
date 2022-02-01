//
//  RestaurantListInteractorTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Gustavo Tiecker on 26/01/22.
//

import XCTest

@testable import DeliveryAppChallenge

class RestaurantListInteractorTests: XCTestCase {

    private let presenterSpy = RestaurantListPresentationLogicSpy()
    private let workerSpy = RestaurantListWorkingSpy()
    
    private lazy var sut = RestaurantListInteractor(presenter: presenterSpy,
                                                    worker: workerSpy)
    
    func test_fetchRestaurantList_whenWorkerReturnsSuccess_shouldCallPresenterWithSuccessError() {
        // Given
        workerSpy.fetchRestaurantListCompletionToBeExecuted = .success([.fixture(name: "Padaria Bolo Fofo"), .fixture(name: "Baita Padaria")])
        
        // When
        sut.fetchRestaurantList(request: .init())
        
        // Then
        XCTAssertTrue(workerSpy.fetchRestaurantListCalled)
        XCTAssertTrue(presenterSpy.presentFetchedRestaurantListCalled)
        
        switch presenterSpy.presentFetchedRestaurantListResponsePassed {
        case .success(let restaurantList):
            XCTAssertNotNil(restaurantList)
            XCTAssertEqual(restaurantList[0].name, "Padaria Bolo Fofo")
            XCTAssertEqual(restaurantList[1].name, "Baita Padaria")
        default:
            XCTFail("Should be a success result.")
        }
    }
    
    func test_fetchRestaurantList_whenWorkerReturnsFailure_shouldCallPresenterWithFailureError() {
        // Given
        let expectedError = ErrorDummy()
        workerSpy.fetchRestaurantListCompletionToBeExecuted = .failure(expectedError)
        
        // When
        sut.fetchRestaurantList(request: .init())
        
        // Then
        XCTAssertTrue(workerSpy.fetchRestaurantListCalled)
        XCTAssertTrue(presenterSpy.presentFetchedRestaurantListCalled)
        
        switch presenterSpy.presentFetchedRestaurantListResponsePassed {
        case.failure(let error):
            XCTAssertNotNil(error)
            XCTAssertNotNil(error as? ErrorDummy)
        default:
            XCTFail("Should be a failure result.")
        }
    }
}
