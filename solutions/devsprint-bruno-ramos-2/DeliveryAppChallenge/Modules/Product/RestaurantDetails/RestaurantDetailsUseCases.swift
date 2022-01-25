//
//  RestaurantDetailsUseCases.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import Foundation

enum RestaurantDetailsUseCases {
    
    enum FechtData {
        struct Request {}
        struct Response {}
        struct ViewModel {}
      //  enum ViewModel {}
    }
    
    enum Error {
        struct Response {
            let error: Swift.Error
        }
        struct ViewModel {}
    }
}
