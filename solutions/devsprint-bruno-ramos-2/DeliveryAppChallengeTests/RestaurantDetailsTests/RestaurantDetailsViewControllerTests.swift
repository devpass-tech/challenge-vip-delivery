//
//  RestaurantDetailsViewControllerTests.swift
//  DeliveryAppChallengeTests
//
//  Created by bruna.drago on 25/01/22.
//

import XCTest

@testable import DeliveryAppChallenge

class RestaurantDetailsViewControllerTests: XCTestCase {
    
    private let viewSpy = RestaurantDetailsViewSpy()
    private let interactorSpy = RestaurantDetailsInteractorSpy()
    private let routerSpy = RestaurantDetailsRouterSpy()

    private lazy var sut = RestaurantDetailsViewController(
        customView: viewSpy,
        interactor: interactorSpy,
        router: routerSpy)
}
