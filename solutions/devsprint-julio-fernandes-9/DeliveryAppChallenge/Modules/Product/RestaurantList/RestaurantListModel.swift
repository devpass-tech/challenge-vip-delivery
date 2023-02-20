//
//  RestaurantListModel.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 19/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum RestaurantListModel {
    
    enum Request {
        case fetchRestaurantList(category: String)
    }
    
    enum Response {
        case dataRestaurantList(response: [Restaurant], category: String)
        case errorRequest(error: Error)
    }
    
    enum ViewModel {
        case restaurantList(list: [RestaurantItemProtocol])
        case fetchError(message: String)
    }
    
    enum Route {
        case goToRestaurantDetail(restaurantName: String)
    }
}
