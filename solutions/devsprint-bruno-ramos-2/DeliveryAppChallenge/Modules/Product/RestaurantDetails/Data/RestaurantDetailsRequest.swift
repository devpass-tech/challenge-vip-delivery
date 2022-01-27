//
//  RestaurantDetailsRequest.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 26/01/22.
//

import Foundation

struct RestaurantDetailsRequest: NetworkRequest {
    var pathURL: String = "restaurant_details.json"
    
    var method: HTTPMethod = .get
}

