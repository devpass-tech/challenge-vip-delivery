//
//  HomeViewConfiguratorTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Julio Fernandes on 01/08/22.
//

import XCTest
@testable import DeliveryApp

class HomeViewConfiguratorTests: XCTestCase {

    func test_make() {
        let sut = HomeViewConfigurator.make(with: HomeViewConfigurator.Dependencies())
        XCTAssertTrue(sut is HomeViewController)
        
        let interactor = (sut as? HomeViewController)?.interactor
        XCTAssertTrue(interactor is HomeViewInteractor)
        
        let presenter = (interactor as? HomeViewInteractor)?.presenter
        XCTAssertTrue(presenter is HomeViewPresenter)
        
        XCTAssertTrue((presenter as? HomeViewPresenter)?.controller is HomeViewController)
    }


}
