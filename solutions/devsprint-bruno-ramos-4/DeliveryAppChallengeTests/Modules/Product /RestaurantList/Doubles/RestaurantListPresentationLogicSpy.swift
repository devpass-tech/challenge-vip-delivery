//
//  RestaurantListPresentationLogicSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by pedro tres on 13/06/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class RestaurantListPresentationLogicSpy: RestaurantListPresentationLogic {
    
    private(set) var presentDataCalledCount = 0
    
    private (set) var presentDataResponsePassed: RestaurantList.Response?
    
    func presentData(response: RestaurantList.Response) {
        presentDataCalledCount += 1
        presentDataResponsePassed = response
    }
}
