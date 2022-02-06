//
//  RestaurantListResponse+Fixtures.swift
//  DeliveryAppChallengeTests
//
//  Created by Gustavo Tiecker on 27/01/22.
//

import Foundation
import XCTest

@testable import DeliveryAppChallenge

extension RestaurantListResponse {
    
    static func fixture(
        name: String = "",
        category: String = "",
        deliveryTime: RestaurantListResponse.DeliveryTime = .fixture()
    ) -> RestaurantListResponse {
        .init(name: name, category: category, deliveryTime: deliveryTime)
    }
}

extension RestaurantListResponse.DeliveryTime {
    
    static func fixture(min: Int = 0, max: Int = 0) -> RestaurantListResponse.DeliveryTime {
        .init(min: min, max: max)
    }
}
