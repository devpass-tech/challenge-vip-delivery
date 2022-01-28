//
//  RestaurantDetailsResponse.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 26/01/22.
//

import Foundation

// MARK: - RestaurantDetailsResponse

struct RestaurantDetailsResponse: Codable {
    let name, category: String
    let deliveryTime: DeliveryTime
    let reviews: Reviews
    let menu: [Menu]
    
    enum CodingKeys: String, CodingKey {
        case name, category
        case deliveryTime = "delivery_time"
        case reviews, menu
    }
}

// MARK: - DeliveryTime

extension RestaurantDetailsResponse {
    struct DeliveryTime: Codable, Equatable {
        let min, max: Int
    }
}

// MARK: - Menu

extension RestaurantDetailsResponse {
    struct Menu: Codable, Equatable {
        let category: Category
        var name: String
        let price: Int
    }
}

// MARK: - Category

extension RestaurantDetailsResponse {
    enum Category: String, Codable, CaseIterable {
        case lunch = "Almoço"
        case breakfast = "Café da manhã"
        case dinner = "Jantar"
    }
}

// MARK: - Reviews

extension RestaurantDetailsResponse {
    struct Reviews: Codable, Equatable {
        let score: Double
        let count: Int
    }
}

extension RestaurantDetailsResponse: Equatable {
    static func == (lhs: RestaurantDetailsResponse, rhs: RestaurantDetailsResponse) -> Bool {
        return
        lhs.name == rhs.name &&
        lhs.category == rhs.category &&
        lhs.reviews == rhs.reviews &&
        lhs.deliveryTime == rhs.deliveryTime
        lhs.menu == rhs.menu
    }
}
