//
//  MenuItemEndpointTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 03/08/22.
//

import XCTest
@testable import DeliveryApp

final class MenuItemEndpointTests: XCTestCase {
    func test_endpoint() {
        let sut = MenuItemEndpoint()
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.pathURL, "menu_item_details.json")
    }
}
