//
//  HomeNetworkResponse.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

struct Restaurant: Codable, RestaurantItemProtocol {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime
    let menu: [Menu]?
    let reviews: Reviews?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case category = "category"
        case deliveryTime = "delivery_time"
        case menu
        case reviews
    }
    
    var info: String {
        return "\(category) • \(deliveryTime.min)-\(deliveryTime.max) min"
    }
}

struct DeliveryTime: Codable {
    let min: Int
    let max: Int
}

struct Reviews: Codable {
    let count: UInt
    let score: Double
}

struct Menu: Codable {
    let category: String
    let name: String
    let price: Double
}

