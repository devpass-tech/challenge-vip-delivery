//
//  SettingsInteractorTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Douglas Garcia on 09/11/22.
//

import XCTest
@testable import DeliveryAppChallenge

final class SettingsInteractorTests: XCTestCase {

    private let presenterSpy = SettingsPresenterSpy()
    
    private var sut: SettingsInteractor {
        let interactor = SettingsInteractor(presenter: presenterSpy)
        return interactor
    }
    
    func testFetchSettings_ShouldAskWorkerSettingsToPresenterCalled() {
        
        // When
        sut.loadData(request: .init())
        
        // Then
        XCTAssertTrue(presenterSpy.presentDataCalled)
    }
}
