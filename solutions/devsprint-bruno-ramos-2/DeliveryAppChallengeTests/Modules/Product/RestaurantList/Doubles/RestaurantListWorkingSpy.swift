//
//  RestaurantListWorkingSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Gustavo Tiecker on 27/01/22.
//

import Foundation

@testable import DeliveryAppChallenge

final class RestaurantListWorkingSpy: RestaurantListWorking {
    
    private(set) var fetchRestaurantListCalled = false
    var fetchRestaurantListCompletionToBeExecuted: Result<[RestaurantListResponse], Error>?
    
    func fetchRestaurantList(completion: @escaping (Result<[RestaurantListResponse], Error>) -> Void) {
        fetchRestaurantListCalled = true
        
        if let fetchRestaurantListCompletionToBeExecuted = fetchRestaurantListCompletionToBeExecuted {
            completion(fetchRestaurantListCompletionToBeExecuted)
        }
    }
}
