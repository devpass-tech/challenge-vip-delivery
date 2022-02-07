//
//  Home.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

typealias Home = [HomeRestaurant]

struct HomeRestaurant {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime
}

extension HomeRestaurant {
    struct DeliveryTime: Codable {
        let min: Int
        let max: Int
    }
}
