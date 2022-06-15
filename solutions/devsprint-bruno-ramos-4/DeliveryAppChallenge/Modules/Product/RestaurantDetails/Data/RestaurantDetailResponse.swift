//
//  RestaurantDetailResponse.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 14/06/22.
//

import Foundation

struct RestaurantDetailResponse: Decodable {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime
    let reviews: Reviews
    let menu: [Menu]
    
    private enum CodingKeys: String, CodingKey {
        case name, category, reviews, menu
        case deliveryTime = "delivery_time"
    }
}

extension RestaurantDetailResponse {
    struct DeliveryTime: Decodable {
        let min: Int
        let max: Int
    }
    
    struct Reviews: Decodable {
        let score: Double
        let count: Int
    }
    
    struct Menu: Decodable {
        let category: String
        let name: String
        let price: Int
    }
}
