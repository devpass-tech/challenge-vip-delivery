//
//  Restaurant.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 10/06/22.
//

import Foundation

struct Restaurant {
    let name: String
    let category: String
    let deliveryTimeMin: Int
    let deliveryTimeMax: Int
    
    init(name: String, category: String, deliveryTimeMin: Int, deliveryTimeMax: Int){
        self.name = name
        self.category = category
        self.deliveryTimeMin = deliveryTimeMin
        self.deliveryTimeMax = deliveryTimeMax
    }
    
    init(from response: RestaurantResponse) {
        self.name = response.name
        self.category = response.category
        self.deliveryTimeMax = response.deliveryTime.max
        self.deliveryTimeMin = response.deliveryTime.min
    }
}
