//
//  MenuItemRepositoryTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 03/08/22.
//

import Foundation

import XCTest
@testable import DeliveryApp

final class MenuItemRepositoryTests: XCTestCase {

    private lazy var network: MenuItemProtocolSpy = MenuItemProtocolSpy()
    private var sut: MenuItemRepository?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MenuItemRepository(network: network)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_should_call_fetchData() {
        sut?.fetchData(completion: { _ in })
        XCTAssertTrue(network.requestCalled)
    }
}

final class MenuItemProtocolSpy: NetworkManagerProtocol {
    private(set) var requestCalled = false
    
    func request<T>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>) where T : Decodable {
        requestCalled = true
    }
}
