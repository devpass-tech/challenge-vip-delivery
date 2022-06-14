//
//  RestaurantListInteractor.swift
//  DeliveryAppChallengeTests
//
//  Created by pedro tres on 13/06/22.
//

import XCTest
@testable import DeliveryAppChallenge

struct ErrorDummy: Error {
}

class RestaurantListInteractorTests: XCTestCase {
    private let presenterSpy = RestaurantListPresentationLogicSpy()
    private let workerStub =  RestaurantListWorkerProtocolStub()
    private lazy var sut = RestaurantListInteractor(
        presenter: presenterSpy,
        worker: workerStub)
    
    func test_fetchData_shouldBeSuccess() {
        
        // Given or arrange
        let restaurant: [Restaurant] = [Restaurant(name: "", category: "", deliveryTimeMin: 0, deliveryTimeMax: 0)]
        workerStub.fetchRestaurantListCompletionToBeExecuted = .success(restaurant)
        
        //when or act
        sut.fetchData(request: .init())
        
        //then or assert
        XCTAssertEqual(presenterSpy.presentDataCalledCount, 1)
        switch presenterSpy.presentDataResponsePassed {
        case .success(let restaurantList):
            XCTAssertFalse(restaurantList.isEmpty)
        default:
            XCTFail("presenter should be success")
        }
    }
    
    func test_fetchData_shouldBeFailure() {
        
        // Given or arrange
        workerStub.fetchRestaurantListCompletionToBeExecuted = .failure(ErrorDummy())
        
        //when or act
        sut.fetchData(request: .init())
        
        //then or assert
        XCTAssertEqual(presenterSpy.presentDataCalledCount, 1)
        switch presenterSpy.presentDataResponsePassed {
        case .failure(let error):
            XCTAssertNotNil(error)
        default:
            XCTFail("presenter should be failure")
        }
    }
}


