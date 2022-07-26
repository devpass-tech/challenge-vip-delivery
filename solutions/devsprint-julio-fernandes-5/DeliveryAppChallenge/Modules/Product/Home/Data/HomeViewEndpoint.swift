//
//  HomeViewEndpoint.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

struct HomeViewEndpoint: NetworkRequest {
    var pathURL: String = "home_restaurant_list.json"
    var method: HTTPMethod = .get
}
