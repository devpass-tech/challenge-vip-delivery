//
//  MenuItemPresenterTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 03/08/22.
//

import XCTest
@testable import DeliveryApp

final class MenuItemPresenterTests: XCTestCase {
    private lazy var controller: MenuItemControllerOutputSpy = MenuItemControllerOutputSpy()
    private var sut: MenuItemPresenter?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MenuItemPresenter()
        sut?.viewController = controller
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_fetchedSuccessData() {
        sut?.fetchedSuccessData()
        XCTAssertTrue(controller.showDataCalled)
    }
    
    func test_fetchedErrorData() {
        sut?.fetchedErrorData()
        XCTAssertTrue(controller.showErrorCalled)
    }
}

final class MenuItemControllerOutputSpy: MenuItemViewControllerOutput {
    private(set) var showDataCalled = false
    private(set) var showErrorCalled = false
    
    func showData() {
        showDataCalled = true
    }
    
    func showError() {
        showErrorCalled = true
    }
}
