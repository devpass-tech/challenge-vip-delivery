import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantDetailsWorkerTests: XCTestCase {
    
    private let networkSpy = NetworkManagerProtocolSpy()
    private lazy var sut = RestaurantDetailsWorker(network: networkSpy)
    
    func test_fetchData_givenSuccessResponse_shouldSucceed() throws {
        //Given
        networkSpy.requestToBeReturned = Result<RestaurantDetailsResponse,Error>.success(.fixture(name: "Condimento Bistro", category: .breakfast, deliveryTime: .fixture(min: 15, max: 30), reviews: .fixture(score: 4.8, count: 10)))
        
        var result: Result<RestaurantDetailsResponse,Error>?
        
        //When
        sut.fetchData { resultReturned in
            result = resultReturned
        }
        
        //Then or Assert
        XCTAssertTrue(networkSpy.requestCalled)
        XCTAssertNotNil(networkSpy.requestPassed as? RestaurantDetailsRequest)
        XCTAssertNotNil(result)
        let details = try XCTUnwrap(result?.get())
        XCTAssertEqual(details.name, "Condimento Bistro")
        XCTAssertEqual(details.category,RestaurantDetailsResponse.Category.breakfast.rawValue)
        XCTAssertEqual(details.reviews, RestaurantDetailsResponse.Reviews(score: 4.8, count: 10))
    }
    
    func test_fetchData_givenFailureResponse_shouldReturnFailure() throws {
        //Given
        networkSpy.requestToBeReturned = Result<RestaurantDetailsResponse, Error>.failure(APIError.networkError)
        
        var result: Result<RestaurantDetailsResponse,Error>?
        
        // When or Act
        sut.fetchData { resultReturned in
            result = resultReturned
        }
        
        //Then or Assert
        XCTAssertTrue(networkSpy.requestCalled)
        XCTAssertNotNil(networkSpy.requestPassed as? RestaurantDetailsRequest)
        
        guard case .failure(let error) = result else {
            return XCTFail("Should be failure")
        }
        
        let networkError = try XCTUnwrap(error as? APIError)
        XCTAssertEqual(networkError, .networkError)
    }
}
