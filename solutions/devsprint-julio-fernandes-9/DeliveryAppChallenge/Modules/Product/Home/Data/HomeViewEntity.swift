//
//  HomeViewEntity.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

struct HomeViewEntity {
    
    let restaurantList: [RestaurantItem]
    let categories: Set<String>
    
    struct RestaurantItem {
        let name: String
        let info: String
    }
}
