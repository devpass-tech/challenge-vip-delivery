//
//  RestaurantListUseCases.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 25/01/22.
//

import Foundation

enum RestaurantListUseCases {
    
    enum FetchData {
        struct Request {}
        
        enum Response {
            case success([RestaurantListResponse])
            case failure(Error)
        }
        
        struct ViewModel {}
    }
}
