//
//  MenuItemInteractorTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 03/08/22.
//

import XCTest
@testable import DeliveryApp

final class MenuItemInteractorTests: XCTestCase {
    private lazy var presenter: MenuItemPresenterProtocolSpy = MenuItemPresenterProtocolSpy()
    private lazy var useCase: MenuItemUseCaseProtocolSpy = MenuItemUseCaseProtocolSpy()
    private var sut: MenuItemInteractor?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MenuItemInteractor(presenter: presenter, useCase: useCase)
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

final class MenuItemPresenterProtocolSpy: MenuItemPresenterProtocol {
    private(set) var fetchedSuccessDataCalled = false
    private(set) var fetchedErrorDataCalled = false
    
    func fetchedSuccessData() {
        fetchedSuccessDataCalled = true
    }
    
    func fetchedErrorData() {
        fetchedErrorDataCalled = true
    }
}

final class MenuItemUseCaseProtocolSpy: MenuItemUseCaseProtocol {
    private(set) var executeCalled = false
    var completionToBeReturned: Result<[MenuItemResponse], Error> = .success([])
    
    func execute(completion: @escaping (Result<[MenuItemResponse], Error>) -> Void) {
        executeCalled = true
        completion(completionToBeReturned)
    }
}
