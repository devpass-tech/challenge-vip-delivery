//
//  RestaurantListPresentationLogicSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Gustavo Tiecker on 27/01/22.
//

import Foundation

@testable import DeliveryAppChallenge

final class RestaurantListPresentationLogicSpy: RestaurantListPresentationLogic {
    
    private(set) var presentFetchedRestaurantListCalled = false
    private(set) var presentFetchedRestaurantListResponsePassed: RestaurantListUseCases.FetchData.Response?
    
    func presentFetchedRestaurantList(response: RestaurantListUseCases.FetchData.Response) {
        presentFetchedRestaurantListCalled = true
        presentFetchedRestaurantListResponsePassed = response
    }
}
