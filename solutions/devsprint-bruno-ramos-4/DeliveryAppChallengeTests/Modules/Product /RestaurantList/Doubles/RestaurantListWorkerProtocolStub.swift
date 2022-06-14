//
//  RestaurantListWorkerProtocolStub.swift
//  DeliveryAppChallengeTests
//
//  Created by pedro tres on 13/06/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class RestaurantListWorkerProtocolStub: RestaurantListWorkerProtocol {
    var fetchRestaurantListCompletionToBeExecuted: Result<[Restaurant], Error>?
    
    func fetchRestaurantList(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        if let fetchRestaurantListCompletionToBeExecuted = fetchRestaurantListCompletionToBeExecuted {
            completion(fetchRestaurantListCompletionToBeExecuted)
        }
    }
}
