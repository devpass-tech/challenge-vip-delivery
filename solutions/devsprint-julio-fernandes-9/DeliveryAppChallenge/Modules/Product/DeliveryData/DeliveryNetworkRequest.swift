//
//  HomeNetworkRequest.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum DeliveryNetworkRequest: NetworkRequest {
    
    case allRestaurants
    case restaurantDetail
    case settings
    case menuItem
    
    var pathURL: String {
        switch self {
        case .allRestaurants:
            return "home_restaurant_list.json"
        case .restaurantDetail:
            return "restaurant_details.json"
        case .settings:
            return "user_settings.json"
        case .menuItem:
            return "menu_item_details.json"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
}
