//
//  HomeResponse+Fixtures.swift
//  DeliveryAppChallengeTests
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation
@testable import DeliveryAppChallenge

extension HomeResponse {
    static func fixture() -> HomeResponse {
        [
            HomeRestaurantResponse.fixture(name: "Casa Arabe", category: "Italina"),
            HomeRestaurantResponse.fixture(name: "Padoca do Alemão"),
            HomeRestaurantResponse.fixture(name: "Comida da vovó"),
            HomeRestaurantResponse.fixture(name: "PFZão das massas")
        ]
    }
}

extension HomeRestaurantResponse {
    static func fixture(name: String = "",
                        category: String  = "",
                        deliveryTime: DeliveryTime = DeliveryTime.fixture()) -> HomeRestaurantResponse {
        .init(name: name, category: category, deliveryTime: deliveryTime)
    }
}

extension HomeRestaurantResponse.DeliveryTime {
    static func fixture(min: Int = 1, max: Int = 500) -> HomeRestaurantResponse.DeliveryTime {
        .init(min: min, max: max)
    }
}
