//
//  Home.swift
//  DeliveryAppChallengeTests
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation
@testable import DeliveryAppChallenge

extension Home {
    static func fixture() -> Home {
        [
            HomeRestaurant.fixture(name: "Casa do Alemão"),
            HomeRestaurant.fixture(name: "Padoca do Flavio"),
            HomeRestaurant.fixture(name: "PF da mamae"),
            HomeRestaurant.fixture(name: "NatuErvas"),
            HomeRestaurant.fixture()
        ]
    }
}

extension HomeRestaurant {
    static func fixture(name: String = "",
                        category: String = "",
                        deliveryTime: DeliveryTime = DeliveryTime.fixture()) -> HomeRestaurant {
        .init(name: name, category: category, deliveryTime: deliveryTime)
    }
}

extension HomeRestaurant.DeliveryTime {
    static func fixture(min: Int = 1,
                        max: Int = 500) -> HomeRestaurant.DeliveryTime {
        .init(min: min, max: max)
    }
}
