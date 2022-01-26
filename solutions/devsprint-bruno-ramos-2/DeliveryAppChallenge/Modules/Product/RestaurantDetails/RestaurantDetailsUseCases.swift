//
//  RestaurantDetailsUseCases.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import Foundation

enum RestaurantDetailsUseCases {
    
    enum FetchMenu {
        struct Request {}

        enum Response {
            case success(String)
            case failure(RestaurantFetchDataError)
        }

        struct ViewModel {
            let name: String
        }
    }
    
    enum Error {
        struct Response {
            let error: Swift.Error
        }
        struct ViewModel {}
    }
}
