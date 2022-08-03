//
//  HomeViewControllerTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Julio Fernandes on 01/08/22.
//

import XCTest
@testable import DeliveryApp

final class HomeViewControllerTests: XCTestCase {

    private lazy var interactor: HomeViewInteractorProtocolSpy = HomeViewInteractorProtocolSpy()
    private var sut: HomeViewController?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeViewController(interactor: interactor)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_initCoder() {
        sut = HomeViewController(coder: NSCoder())
        XCTAssertNil(sut)
    }

    func test_viewDidLoad() {
        sut?.viewDidLoad()
        XCTAssertEqual(sut?.navigationItem.title, "Delivery App")
        XCTAssertNotNil(sut?.navigationItem.rightBarButtonItem)
    }
    
    func test_viewDidAppear() {
        sut?.viewDidAppear(true)
        XCTAssertTrue(interactor.fetchDataCalled)
    }
    
    func test_loadView() {
        sut?.loadView()
        XCTAssertTrue(sut?.view is HomeView)
    }

}

final class HomeViewTests: XCTestCase {
    
    func test_initCoder() {
        let sut = HomeView(coder: NSCoder())
        XCTAssertNil(sut)
    }
}

final class HomeViewInteractorProtocolSpy: HomeViewInteractorProtocol {
    
    private(set) var fetchDataCalled = false
    func fetchData() {
        fetchDataCalled = true
    }
    
}
