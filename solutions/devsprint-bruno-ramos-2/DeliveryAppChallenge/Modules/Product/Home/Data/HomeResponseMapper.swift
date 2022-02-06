//
//  HomeResponseMapper.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

extension Home {
    init(from response: HomeResponse) {
        self = response.compactMap(HomeRestaurant.init)
    }
}


extension HomeRestaurant {
    init(from response: HomeRestaurantResponse) {
        self.name = response.name
        self.category = response.category
        self.deliveryTime = HomeRestaurant.DeliveryTime(from: response.deliveryTime)
    }
}

extension HomeRestaurant.DeliveryTime {
    init(from response: HomeRestaurantResponse.DeliveryTime) {
        self.min = response.min
        self.max = response.max
    }
}
