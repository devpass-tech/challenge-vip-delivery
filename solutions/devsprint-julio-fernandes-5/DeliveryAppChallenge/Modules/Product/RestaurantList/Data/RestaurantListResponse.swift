//
//  RestaurantListResponse.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

/// Estrutura de dados vindo da API
struct RestaurantListResponse: Decodable {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime
    
    private enum CodingKeys: String, CodingKey {
        case name, category
        case deliveryTime = "delivery_time"
    }
}

extension RestaurantListResponse {
    struct DeliveryTime: Decodable {
        let min: Int
        let max: Int
    }
}

extension RestaurantListResponse {
    var detail: String {
        return "\(category) • \(deliveryTime.min)-\(deliveryTime.max) mins"
    }
}
