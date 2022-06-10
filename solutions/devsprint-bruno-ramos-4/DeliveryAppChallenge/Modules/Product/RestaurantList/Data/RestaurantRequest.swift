//
//  RestaurantRequest.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 10/06/22.
//

import Foundation

struct RestaurantRequest: NetworkRequest {
    var pathURL = "home_restaurant_list"
    var method = HTTPMethod.get
}
