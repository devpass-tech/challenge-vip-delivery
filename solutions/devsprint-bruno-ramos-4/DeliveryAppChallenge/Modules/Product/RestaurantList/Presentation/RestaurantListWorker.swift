//
//  RestaurantListWorker.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 10/06/22.
//

import Foundation

protocol RestaurantListWorkerProtocol {
    func fetchRestaurantList(completion: @escaping (Result<[Restaurant], Error>) -> Void)
}

final class RestaurantListWorker: RestaurantListWorkerProtocol {
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
    
    func fetchRestaurantList(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        network.request(RestaurantRequest()) {(result: Result<[RestaurantResponse], Error>) in
            switch result {
            case .success(let restaurantResponseList):
                let restaurantList = restaurantResponseList.map(Restaurant.init)
                completion(.success(restaurantList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
