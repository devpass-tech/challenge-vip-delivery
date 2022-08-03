//
//  MenuItemConfiguratorTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 03/08/22.
//

import XCTest
@testable import DeliveryApp

final class MenuItemConfiguratorTests: XCTestCase {
    func test_menuItemMake() {
        let sut = MenuItemConfigurator.make(with: MenuItemConfigurator.Dependencies())
        let interactor = (sut as? MenuItemViewController)?.interactor
        let presenter = (interactor as? MenuItemInteractor)?.presenter

        XCTAssertTrue(sut is MenuItemViewController)
        XCTAssertTrue(interactor is MenuItemInteractor)
        XCTAssertTrue(presenter is MenuItemPresenter)
        XCTAssertTrue((presenter as? MenuItemPresenter)?.viewController is MenuItemViewController)
    }
}
