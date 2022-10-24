//
//  RestaurantDetailRepository.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 04/08/22.
//

import Foundation

protocol RestaurantDetailRepositoryProtocol {
    func fetchData(completion: @escaping (Result<RestaurantDetailResponse, NetworkError>) -> Void)
}

final class RestaurantDetailRepository {
    let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
}

extension RestaurantDetailRepository: RestaurantDetailRepositoryProtocol {
    func fetchData(completion: @escaping (Result<RestaurantDetailResponse, NetworkError>) -> Void) {
        network.request(RestaurantDetailEndpoint()) { (response: Result<RestaurantDetailResponse, Error>) in
            switch response {
            case .success(let data): completion(.success(data))
            case .failure: completion(.failure(NetworkError.networkError))
            }
        }
    }
}
