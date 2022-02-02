//
//  ResturantListWorkerTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Gustavo Tiecker on 31/01/22.
//

import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantListWorkerTests: XCTestCase {
    
    private let networkSpy = NetworkManagerProtocolSpy()
    private lazy var sut = RestaurantListWorker(network: networkSpy)
    
    func test_fetchRestaurantList_givenSuccessResponse_shouldSucceed() throws {
        // Given
        networkSpy.requestToBeReturned = Result<[RestaurantListResponse], Error>.success([.fixture(name: "Padaria Bolo Fofo"), .fixture(name: "Baita Padaria")])
        
        var result: Result<[RestaurantListResponse], Error>?
        
        // When
        sut.fetchRestaurantList { receivedResult in
            result = receivedResult
        }
        
        // Then
        guard case .success(_) = result else {
            return XCTFail("Should be success")
        }
        
        XCTAssertTrue(networkSpy.requestCalled)
        XCTAssertNotNil(networkSpy.requestPassed as? RestaurantListRequest)
        XCTAssertNotNil(result)
        
        let restaurantList = try XCTUnwrap(result?.get())
        XCTAssertTrue(restaurantList.contains { $0.name == "Padaria Bolo Fofo" })
        XCTAssertTrue(restaurantList.contains { $0.name == "Baita Padaria" })
    }
    
    func test_fetchRestaurantList_givenFailureResponse_shouldFail() throws {
        // Given
        let expectedError = ErrorDummy()
        networkSpy.requestToBeReturned = Result<[RestaurantListResponse], Error>.failure(expectedError)
        
        var result: Result<[RestaurantListResponse], Error>?
        
        // When
        sut.fetchRestaurantList { receivedResult in
            result = receivedResult
        }
        
        // Then
        XCTAssertTrue(networkSpy.requestCalled)
        XCTAssertNotNil(networkSpy.requestPassed as? RestaurantListRequest)
        XCTAssertNotNil(result)
        
        guard case .failure(let error) = result else {
            return XCTFail("Should be failure")
        }
        
        let receivedError = try XCTUnwrap(error)
        XCTAssertNotNil(receivedError)
        XCTAssertNotNil(error as? ErrorDummy)
    }
}
