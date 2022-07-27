//
//  DeliveryAppChallengeTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Rodrigo Borges on 25/10/21.
//

import XCTest
@testable import DeliveryAppChallenge

class DeliveryAppChallengeTests: XCTestCase {

    let connectivityManagerSpy = ConnectivityManagerSpy()
    let delegateObserver = LoginServiceDelegateSpy()
    let networkLayerSpy = NetworkLayerSpy()

    lazy var sut = LoginService(
        connectivityManager: connectivityManagerSpy,
        networkLayer: networkLayerSpy
    )

    func testLogin_WhenIsNotConnected_ShouldCallNoInternetDelegate() {
        //given
        sut.delegate = delegateObserver
        connectivityManagerSpy.isConnectedSetter = false

        //when
        sut.login()

        //then
        XCTAssertEqual(delegateObserver.noInternetCounter, 1)
    }

    func testLogin_WhenIsConnected_ShouldCallLoginAPI() {
        //given
        connectivityManagerSpy.isConnectedSetter = true

        //when
        sut.login()

        //then
        XCTAssertEqual(networkLayerSpy.loginCounter, 1)

    }
}



class ConnectivityManagerSpy: ConnectivityManaging {
    var isConnectedSetter = false

    var isConnected: Bool {
        return isConnectedSetter
    }
}

class LoginServiceDelegateSpy: LoginServiceDelegate {
    private(set) var didSuccedLoginCounter = 0
    private(set) var didFailLoginCounter = 0
    private(set) var noInternetCounter = 0


    func didSuccedLogin() {
        didSuccedLoginCounter += 1
    }

    func didFailLogin() {
        didFailLoginCounter += 1
    }

    func noInternet() {
        noInternetCounter += 1
    }
}

class NetworkLayerSpy: NetworkLayer {
    private(set) var loginCounter = 0

    func login(_ targetVc: UIViewController, parameters: [String : String], completionHandler: @escaping (Session?) -> Void) {
        loginCounter += 1
    }
}
