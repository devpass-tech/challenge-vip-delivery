//
//  RestaurantListWorker.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 27/01/22.
//

import Foundation

protocol RestaurantListWorking {}

final class RestaurantListWorker: RestaurantListWorking {
    
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
}
