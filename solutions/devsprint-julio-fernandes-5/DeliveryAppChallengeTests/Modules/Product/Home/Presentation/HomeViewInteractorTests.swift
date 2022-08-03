//
//  HomeViewInteractorTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Julio Fernandes on 01/08/22.
//

import XCTest
@testable import DeliveryApp

final class HomeViewInteractorTests: XCTestCase {
    
    private lazy var presenter: HomeViewPresenterProtocolSpy = HomeViewPresenterProtocolSpy()
    private lazy var useCase: HomeViewUseCaseProtocolSpy = HomeViewUseCaseProtocolSpy()
    private var sut: HomeViewInteractor?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeViewInteractor(presenter: presenter, useCase: useCase)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_should_call_cafetchData() {
        sut?.fetchData()
        XCTAssertTrue(useCase.executeCalled)
    }
    
    func test_should_call_cafetchData_and_callback_success_data() {
        sut?.fetchData()
        XCTAssertTrue(presenter.fetchedSuccessDataCalled)
    }
    
    func test_should_call_cafetchData_and_callback_error_data() {
        useCase.completionToBeReturned = .failure(ErrorMock.notFound)
        sut?.fetchData()
        XCTAssertTrue(presenter.fetchedErrorDataCalled)
    }

}

final class HomeViewPresenterProtocolSpy: HomeViewPresenterProtocol {
    
    private(set) var fetchedSuccessDataCalled = false
    func fetchedSuccessData() {
        fetchedSuccessDataCalled = true
    }
    
    private(set) var fetchedErrorDataCalled = false
    func fetchedErrorData() {
        fetchedErrorDataCalled = true
    }

}

final class HomeViewUseCaseProtocolSpy: HomeViewUseCaseProtocol {
    
    private(set) var executeCalled = false
    var completionToBeReturned: Result<[RestaurantDetailResponse], Error> = .success([])
    func execute(completion: @escaping (Result<[RestaurantDetailResponse], Error>) -> Void) {
        executeCalled = true
        completion(completionToBeReturned)
    }
    
}

enum ErrorMock: Error {
    case notFound
}
