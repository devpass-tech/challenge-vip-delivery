//
//  RestaurantDetailsModel.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 20/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum RestaurantDetailsModel {
    
    enum Request {
        case fetchRestaurantDetail
    }
    
    enum Response {
        case hasRestaurantDetail(response: Restaurant)
        case errorRestaurantDetail(error: Error)
    }
    
    enum ViewModel {
        case viewModel(restaurant: Restaurant)
        case viewModelWithError(messageError: String)
    }
    
    enum Route {
        case goToMenuItem
    }
}
