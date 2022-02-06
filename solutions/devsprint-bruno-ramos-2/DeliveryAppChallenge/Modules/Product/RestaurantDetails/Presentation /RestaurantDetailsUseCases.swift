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
            case success(RestaurantDetails)
            case failure(Error)
        }

        struct ViewModel {
            let name: String
        }
    }
}
