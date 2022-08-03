//
//  MenuItemUseCaseTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 03/08/22.
//

import XCTest
@testable import DeliveryApp

final class MenuItemUseCaseTests: XCTestCase {
    private lazy var repository: MenuItemRepositoryProtocolSpy = MenuItemRepositoryProtocolSpy()
    private var sut: MenuItemUseCase?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MenuItemUseCase(repository: repository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_menuItemExecute() throws {
        sut?.execute(completion: { _ in })
        XCTAssertTrue(repository.fetchDataCalled)
    }
}

final class MenuItemRepositoryProtocolSpy: MenuItemRepositoryProtocol {
    private(set) var fetchDataCalled = false
    
    func fetchData(completion: @escaping (Result<[MenuItemResponse], NetworkError>) -> Void) {
        fetchDataCalled = true
    }
}
