//
//  RestaurantListRequest.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 27/01/22.
//

import Foundation

struct RestaurantListRequest: NetworkRequest {
    
    let pathURL: String = "home_restaurant_list.json"
    let method: HTTPMethod = .get
}
