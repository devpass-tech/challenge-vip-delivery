//
//  HomeViewEntity.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

struct HomeViewEntity {
    
    let restaurantList: [RestaurantItemProtocol]
    let categories: Set<String>
}
