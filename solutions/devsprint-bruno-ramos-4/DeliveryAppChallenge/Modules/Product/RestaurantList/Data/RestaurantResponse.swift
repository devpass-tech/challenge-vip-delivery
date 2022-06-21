//
//  RestaurantResponse.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 10/06/22.
//

struct RestaurantResponse: Codable {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime
    
}

extension RestaurantResponse {
    struct DeliveryTime: Codable {
        let min: Int
        let max: Int
    }
}
