//
//  Restaurant.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 02/11/22.
//

import Foundation

struct Restaurant: Decodable {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime
    
    enum CodingKeys: String, CodingKey {
        case name, category
        case deliveryTime = "delivery_time"
    }
}

struct DeliveryTime: Decodable {
    let min: Int
    let max: Int
}

typealias RestaurantsList = [Restaurant]
