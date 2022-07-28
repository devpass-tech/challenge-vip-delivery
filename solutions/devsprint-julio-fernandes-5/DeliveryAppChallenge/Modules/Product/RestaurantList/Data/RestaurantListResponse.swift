//
//  RestaurantListResponse.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

struct RestaurantListResponse: Decodable {
    let name: String
    let category: String
    let deliveryTime: RestaurantDetailResponse.DeliveryTime
    let reviews: Reviews
    let menu: [Product]
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
