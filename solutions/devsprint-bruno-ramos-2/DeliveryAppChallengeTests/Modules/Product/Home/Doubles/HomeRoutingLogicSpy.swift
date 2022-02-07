//
//  HomeRoutingLogicSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class HomeRoutingLogicSpy: HomeRoutingLogic {

    private(set) var routeToNextModuleCalled = false
    func routeToNextModule() {
        routeToNextModuleCalled = true
    }
}
