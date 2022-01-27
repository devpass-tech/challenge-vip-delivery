//
//  RestaurantDetailsResponse.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 26/01/22.
//

import Foundation

// MARK: - RestaurantDetailsResponse

struct RestaurantDetailsResponse: Codable {
    let name, category: String
    let deliveryTime: DeliveryTime
    let reviews: Reviews
    let menu: [Menu]
    
    enum CodingKeys: String, CodingKey {
        case name, category
        case deliveryTime = "delivery_time"
        case reviews, menu
    }
}

// MARK: - DeliveryTime

extension RestaurantDetailsResponse {
    struct DeliveryTime: Codable {
        let min, max: Int
    }
    
    struct Menu: Codable {
        let category: Category
        let name: String
        let price: Int
    }
    
    enum Category: String, Codable {
        case lunch = "Almoço"
        case breakfast = "Café da manhã"
        case dinner = "Jantar"
    }
    
    struct Reviews: Codable {
        let score: Double
        let count: Int
    }
}
