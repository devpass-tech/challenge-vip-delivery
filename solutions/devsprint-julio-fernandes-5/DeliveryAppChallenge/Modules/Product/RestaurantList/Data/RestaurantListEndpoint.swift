//
//  RestaurantListEndpoint.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

import Foundation

struct RestaurantListEndpoint: NetworkRequest {
    var pathURL: String = "home_restaurant_list.json"
    var method: HTTPMethod = .get
}
