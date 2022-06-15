//
//  RestaurantDetailsWorker.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 14/06/22.
//

import Foundation

protocol RestaurantDetailsWorkerProtocol {
    func loadRestaurantDetails(completion: @escaping (Result<RestaurantDetail, Error>) -> Void)
}

struct RestaurantDetailsWorker {
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
}

extension RestaurantDetailsWorker: RestaurantDetailsWorkerProtocol {
    
    func loadRestaurantDetails(completion: @escaping (Result<RestaurantDetail, Error>) -> Void) {
        let request = RestaurantDetailRequest()

        network.request(request) { (result: Result<RestaurantDetailResponse, Error>) in
            switch result {
                case let .success(response):
                    let restaurantDetail = RestaurantDetail(response: response)
                    completion(.success(restaurantDetail))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }

}
