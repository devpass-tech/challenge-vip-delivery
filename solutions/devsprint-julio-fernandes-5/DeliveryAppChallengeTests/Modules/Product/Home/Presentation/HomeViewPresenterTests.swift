//
//  HomeViewPresenterTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Julio Fernandes on 01/08/22.
//

import XCTest
@testable import DeliveryApp

final class HomeViewPresenterTests: XCTestCase {

    private lazy var controller: HomeViewControllerOutputSpy = HomeViewControllerOutputSpy()
    private var sut: HomeViewPresenter?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeViewPresenter()
        sut?.controller = controller
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_fetchedSuccessData() {
        sut?.fetchedSuccessData(makeHomeViewModel())
        XCTAssertTrue(controller.showDataCalled)
    }
    
    func test_fetchedErrorData() {
        sut?.fetchedErrorData()
        XCTAssertTrue(controller.showErrorCalled)
    }

}

final class HomeViewControllerOutputSpy: HomeViewControllerOutput {
    private(set) var showDataCalled = false
    func showData(_ data: RestaurantDetailResponse.HomeViewModel) {
        showDataCalled = true
    }
    
    private(set) var showErrorCalled = false
    func showError() {
        showErrorCalled = true
    }
}

extension XCTestCase {
    func makeHomeViewModel() -> RestaurantDetailResponse.HomeViewModel {
        return RestaurantDetailResponse.HomeViewModel(list: [], address: SettingsViewResponse(name: "name", email: "email", address: "address", paymentMethod: "paymentMethod"))
    }
}
