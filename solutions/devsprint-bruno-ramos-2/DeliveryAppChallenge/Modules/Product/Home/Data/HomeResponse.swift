//
//  HomeResponse.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

typealias HomeResponse = [HomeRestaurantResponse]

struct HomeRestaurantResponse: Codable {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime

    private enum CodingKeys: String, CodingKey {
        case name, category
        case deliveryTime = "delivery_time"
    }
}

extension HomeRestaurantResponse {
    struct DeliveryTime: Codable {
        let min: Int
        let max: Int
    }
}
