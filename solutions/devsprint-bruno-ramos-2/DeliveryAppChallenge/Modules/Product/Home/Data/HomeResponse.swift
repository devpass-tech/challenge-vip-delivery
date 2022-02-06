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
}

extension HomeRestaurantResponse {
    struct DeliveryTime: Codable {
        let min: Int
        let max: Int
    }
}
