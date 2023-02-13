//
//  HomeNetworkResponse.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case category = "category"
        case deliveryTime = "delivery_time"
    }
}

struct DeliveryTime: Codable {
    let min: Int
    let max: Int
}

