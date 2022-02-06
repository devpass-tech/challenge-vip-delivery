//
//  RestaurantListRequestTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Gustavo Tiecker on 31/01/22.
//

import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class RestaurantListRequestTests: XCTestCase {
    
    private let pathURLStub = "home_restaurant_list.json"
    private let httpMethodStub: HTTPMethod = .get
    
    private lazy var sut = RestaurantListRequest()
    
    override func setUp() {
        sut.pathURL = pathURLStub
        sut.method = httpMethodStub
    }
    
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
