//
//  RestaurantListWorker.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 27/01/22.
//

import Foundation

protocol RestaurantListWorking {
    func fetchRestaurantList(completion: @escaping (Result<[RestaurantListResponse], Error>) -> Void)
}

final class RestaurantListWorker {
    
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
}

extension RestaurantListWorker: RestaurantListWorking {
    
    func fetchRestaurantList(completion: @escaping (Result<[RestaurantListResponse], Error>) -> Void) {
        network.request(RestaurantListRequest()) { (result: Result<[RestaurantListResponse], Error>) in
            completion(result)
        }
    }
}
