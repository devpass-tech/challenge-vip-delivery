import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantDetailsRequestTests: XCTestCase {
    
    private let pathURLPassed = "restaurant_details.json"
    private let httpMethodPassed: HTTPMethod = .get
    
    private lazy var sut = RestaurantDetailsRequest(pathURL: pathURLPassed, method:  httpMethodPassed)
    
    func test_pathURL_shouldReturnCorrectPathURL() {
        let path = sut.pathURL
        
        XCTAssertEqual(path,pathURLPassed)
        XCTAssertNotEqual(path,"restaurant_details")
    }
    
    func test_method_shouldReturn_Get() {
        let method = sut.method
        let post: HTTPMethod = .post
        
        XCTAssertEqual(method, httpMethodPassed)
        XCTAssertNotEqual(method, post)
    }
}
