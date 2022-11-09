//
//  SettingsViewControllerTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Douglas Garcia on 09/11/22.
//

import XCTest
@testable import DeliveryAppChallenge

final class SettingsViewControllerTests: XCTestCase {
    
    private let customViewDummy = SettingsViewDummy()
    private let presenterDummy = SettingsPresenterDummy()
    private lazy var interactorSpy = SettingsInteractorSpy(
        presenter: presenterDummy
    )
    
    private lazy var sut = SettingsViewController(
        customView: customViewDummy,
        interactor: interactorSpy
    )
    
    func testLoadData_SouldAskInteractorIfLoadedWasCalled() {
        
        // When
        sut.interactor.loadData(request: .init())
        
        // Then
        XCTAssertTrue(interactorSpy.loadDataCalled)
    }
}
