//
//  RestaurantDetailEndpoint.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 04/08/22.
//

import Foundation

struct RestaurantDetailEndpoint: NetworkRequest {
    var pathURL: String = "restaurant_details.json"
    var method: HTTPMethod = .get
}
