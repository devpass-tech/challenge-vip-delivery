//
//  HomeInteractorTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Leonardo Mendes on 06/02/22.
//

import XCTest
@testable import DeliveryAppChallenge

final class HomeInteractorTests: XCTestCase {
    private let presenterSpy = HomePresentationLogicSpy()
    private let getHomeUseCaseSpy = GetHomeUseCaseSpy()
    private lazy var sut = HomeInteractor(presenter: presenterSpy, getHome: getHomeUseCaseSpy)

    func test_requestFetchHome_returningSuccess_shouldCallPresenterWithSuccessContent() throws {
        let homeFixture = Home.fixture()
        getHomeUseCaseSpy.executeCompletionToBeReturned = .success(homeFixture)

        sut.fetchHome(request: .init())

        XCTAssertTrue(getHomeUseCaseSpy.executeCalled)
        XCTAssertTrue(presenterSpy.presentHomeDataCalled)

        let responsePassed = try XCTUnwrap(presenterSpy.responsePassed)
        switch responsePassed {
        case .success(let response):
            XCTAssertEqual(response.count, 5)
            XCTAssertEqual(response[0].name, "Casa do Alemão")
        default:
            XCTFail("Must be a success result")
        }
    }

    func test_requestFetchHome_returningError_shouldCallPresenterWithError() throws {
        let error = EmptyCache()
        getHomeUseCaseSpy.executeCompletionToBeReturned = .failure(error)

        sut.fetchHome(request: .init())

        let responsePassed = try XCTUnwrap(presenterSpy.responsePassed)
        switch responsePassed {
        case .failure(let error):
            XCTAssertNotNil(error)
        default:
            XCTFail("Must be a error result")
        }
    }
}
