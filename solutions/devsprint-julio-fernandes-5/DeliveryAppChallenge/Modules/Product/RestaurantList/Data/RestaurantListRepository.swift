//
//  RestaurantListRepository.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

import Foundation

protocol RestaurantListRepositoryProtocol {
    func fetchData(completion: @escaping (Result<RestaurantListResponse, NetworkError>) -> Void)
}

final class RestaurantListRepository {
    
    let network: NetworkManagerProtocol

        init(network: NetworkManagerProtocol) {
            self.network = network
        }
}

extension RestaurantListRepository: RestaurantListRepositoryProtocol {
    func fetchData(completion: @escaping (Result<RestaurantListResponse, NetworkError>) -> Void) {
        network.request(RestaurantListEndpoint()) { (response: Result<RestaurantListResponse, Error>) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure:
                completion(.failure(NetworkError.networkError))
            }
        }
    }
    
    
}
