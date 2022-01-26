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
        struct Response {}
        struct ViewModel {}
    }
    
    enum Error {
        struct Response {
            let error: Swift.Error
        }
        struct ViewModel {}
    }
}
