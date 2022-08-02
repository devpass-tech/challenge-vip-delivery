//
//  HomeViewUseCaseTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Julio Fernandes on 01/08/22.
//

import XCTest
@testable import DeliveryApp

final class HomeViewUseCaseTests: XCTestCase {
    
    private lazy var repository: HomeViewRepositoryProtocolSpy = HomeViewRepositoryProtocolSpy()
    private var sut: HomeViewUseCase?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeViewUseCase(repository: repository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_execute() throws {
        sut?.execute(completion: { _ in })
        XCTAssertTrue(repository.fetchDataCalled)
    }

}

final class HomeViewRepositoryProtocolSpy: HomeViewRepositoryProtocol {
    
    private(set) var fetchDataCalled = false
    func fetchData(completion: @escaping (Result<[RestaurantDetailResponse], NetworkError>) -> Void) {
        fetchDataCalled = true
    }
    
}
