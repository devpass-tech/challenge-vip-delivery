//
//  RestaurantListUseCases.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 08/06/22.
//

import Foundation

enum RestaurantList {
    
    struct Request {}
    
    enum Response {
        case success([Restaurant])
        case failure(Error)
    }
    
    struct ViewModel {}
}
