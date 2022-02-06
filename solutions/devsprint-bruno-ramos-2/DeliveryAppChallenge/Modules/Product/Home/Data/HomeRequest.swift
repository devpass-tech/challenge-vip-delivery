//
//  HomeRequest.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation
 
struct HomeRequest: NetworkRequest {
    var method: HTTPMethod = .get
    var pathURL: String = "home_restaurant_list.json"
}
