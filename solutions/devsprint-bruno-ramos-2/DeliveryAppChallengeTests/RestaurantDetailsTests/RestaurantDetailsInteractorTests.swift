//
//  RestaurantDetailsInteractorTests.swift
//  DeliveryAppChallengeTests
//
//  Created by bruna.drago on 25/01/22.
//

import XCTest

@testable import DeliveryAppChallenge

class RestaurantDetailsInteractorTests: XCTestCase {
    
    private let presenterSpy = RestaurantDetailsPresenterSpy()
    private lazy var sut = RestaurantDetailsInteractor(presenter: presenterSpy)
}
