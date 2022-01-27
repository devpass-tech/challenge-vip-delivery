//
//  RestaurantDetailsResponse+Fixtures.swift
//  DeliveryAppChallengeTests
//
//  Created by bruna.drago on 26/01/22.
//

import Foundation
@testable import DeliveryAppChallenge

extension RestaurantDetailsResponse {
    
    static func fixture(name: String = "", category: String = "", deliveryTime: DeliveryTime = .fixture(), reviews: Reviews = .fixture()) -> RestaurantDetailsResponse {
        
        .init(name: name, category: category, deliveryTime: deliveryTime, reviews: reviews, menu: [])
    }
}

extension RestaurantDetailsResponse.DeliveryTime {
    static func fixture(min: Int = 0, max: Int = 0) -> RestaurantDetailsResponse.DeliveryTime {
        .init(min: min, max: max)
    }
}

extension RestaurantDetailsResponse.Reviews {
    static func fixture(score: Double = 0, count: Int = 0) -> RestaurantDetailsResponse.Reviews {
        .init(score: score, count: count)
    }
}

extension RestaurantDetailsResponse.Category {
    static func fixture() -> RestaurantDetailsResponse.Category {
        .init(rawValue: "")! 
    }
}

extension RestaurantDetailsResponse.Menu {
    static func fixture(category: RestaurantDetailsResponse.Category(rawValue: ""), name: String = "", price: Int = 0) -> RestaurantDetailsResponse.Menu {
        .init(category: category, name: name, price: price)
    }
}
