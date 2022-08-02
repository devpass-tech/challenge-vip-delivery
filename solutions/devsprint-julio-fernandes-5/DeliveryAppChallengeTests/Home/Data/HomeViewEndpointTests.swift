//
//  HomeViewEndpointTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Julio Fernandes on 01/08/22.
//

import XCTest
@testable import DeliveryApp

final class HomeViewEndpointTests: XCTestCase {

    func test_initlializer() {
        let sut = HomeViewEndpoint()
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.pathURL, "home_restaurant_list.json")
    }

}
