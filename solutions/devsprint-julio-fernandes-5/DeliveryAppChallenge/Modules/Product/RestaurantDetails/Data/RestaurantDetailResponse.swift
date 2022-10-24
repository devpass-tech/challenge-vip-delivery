//
//  RestaurantDetailResponse.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

struct RestaurantDetailResponse: Decodable {
    let name: String
    let category: String
    let deliveryTime: RestaurantListResponse.DeliveryTime
    let reviews: Reviews
    let menu: [Product]
    
    private enum CodingKeys: String, CodingKey {
        case name, category, reviews, menu
        case deliveryTime = "delivery_time"
    }
}

struct Reviews: Decodable {
    let score: Double
    let count: Int
}

struct Product: Decodable {
    let category: String
    let name: String
    let price: Double
}

struct RestaurantDetailViewModel {
    let infoView: RestaurantListResponse
    let reviews: Reviews
    let menu: [Product]
}
