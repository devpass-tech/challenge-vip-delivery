//
//  RestaurantDetail.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 14/06/22.
//

import Foundation

struct RestaurantDetail {
    let name: String
    let category: String
    let deliveryTimeMin: Int
    let deliveryTimeMax: Int
    let reviewsScore: Double
    let reviewsCount: Int
    
    init(response: RestaurantDetailResponse) {
        self.name = response.name
        self.category = response.category
        self.deliveryTimeMin = response.deliveryTime.min
        self.deliveryTimeMax = response.deliveryTime.max
        self.reviewsScore = response.reviews.score
        self.reviewsCount = response.reviews.count
    }
}
