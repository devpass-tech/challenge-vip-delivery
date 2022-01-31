//
//  RestaurantDetailsResponse+Fixtures.swift
//  DeliveryAppChallengeTests
//
//  Created by bruna.drago on 26/01/22.
//

import Foundation
@testable import DeliveryAppChallenge
import XCTest

// MARK: - RestaurantDetailsResponse

extension RestaurantDetailsResponse {
    
    static func fixture(
        name: String = "",
        category: Category = .lunch,
        deliveryTime: DeliveryTime = .fixture(),
        reviews: Reviews = .fixture(),
        menu: Menu = .fixture()
    ) -> RestaurantDetailsResponse {
        
        .init(name: name, category: category.rawValue, deliveryTime: deliveryTime, reviews: reviews, menu: [])
    }
}

// MARK: - DeliveryTime

extension RestaurantDetailsResponse.DeliveryTime {
    static func fixture(min: Int = 0, max: Int = 0) -> RestaurantDetailsResponse.DeliveryTime {
        .init(min: min, max: max)
    }
}

// MARK: - Reviews

extension RestaurantDetailsResponse.Reviews {
    static func fixture(score: Double = 0, count: Int = 0) -> RestaurantDetailsResponse.Reviews {
        .init(score: score, count: count)
    }
}

// MARK: - Menu

extension RestaurantDetailsResponse.Menu {
    static func fixture(
        category: RestaurantDetailsResponse.Category = .lunch,
        name: String = "",
        price: Int = 0)
    -> RestaurantDetailsResponse.Menu {
        .init(category: category, name: name, price: price)
    }
}
