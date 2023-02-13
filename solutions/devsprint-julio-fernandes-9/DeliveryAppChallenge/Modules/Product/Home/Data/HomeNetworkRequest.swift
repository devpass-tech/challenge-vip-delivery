//
//  HomeNetworkRequest.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum HomeNetworkRequest: NetworkRequest {
    
    case fetchDataView
    
    var pathURL: String {
        return "home_restaurant_list.json"
    }
    
    var method: HTTPMethod {
        .get
    }
}
