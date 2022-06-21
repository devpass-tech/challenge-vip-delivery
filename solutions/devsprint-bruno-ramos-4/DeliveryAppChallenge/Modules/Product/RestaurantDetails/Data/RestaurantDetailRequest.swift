//
//  RestaurantDetailRequest.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 14/06/22.
//

import Foundation

struct RestaurantDetailRequest: NetworkRequest {
    var pathURL: String = "restaurant_details.json"
    var method: HTTPMethod = .get
}
