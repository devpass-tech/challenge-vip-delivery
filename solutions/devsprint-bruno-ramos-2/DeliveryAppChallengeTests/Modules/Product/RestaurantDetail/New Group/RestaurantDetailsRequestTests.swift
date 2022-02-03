import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantDetailsRequestTests: XCTestCase {
    
    private let pathURLStub = "restaurant_details.json"
    private let httpMethodStub: HTTPMethod = .get
    
    private lazy var sut = RestaurantDetailsRequest(restaurantId: "Foo", method:  httpMethodStub)
    
    func test_pathURL_shouldReturnCorrectPathURL() {
        let path = sut.pathURL
        
        XCTAssertEqual(path,pathURLStub)
        XCTAssertNotEqual(path,"restaurant_details")
    }
    
    func test_method_shouldReturn_Get() {
        let method = sut.method
        let post: HTTPMethod = .post
        
        XCTAssertEqual(method, httpMethodStub)
        XCTAssertNotEqual(method, post)
    }
}
