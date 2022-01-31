//
//  RestaurantListResponse.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 27/01/22.
//

import Foundation

// MARK: - RestaurantListResponse
struct RestaurantListResponse: Codable {
    let name, category: String
    let deliveryTime: DeliveryTime

    enum CodingKeys: String, CodingKey {
        case name, category
        case deliveryTime = "delivery_time"
    }
}

// MARK: - DeliveryTime
extension RestaurantListResponse {
    struct DeliveryTime: Codable {
        let min, max: Int
    }
}
