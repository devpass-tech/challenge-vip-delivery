//
//  MenuItemRepository.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 29/07/22.
//

import Foundation

protocol MenuItemRepositoryProtocol {
    func fetchData(completion: @escaping (Result<[MenuItemResponse], NetworkError>) -> Void)
}

final class MenuItemRepository {
    let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
}

extension MenuItemRepository: MenuItemRepositoryProtocol {
    func fetchData(completion: @escaping (Result<[MenuItemResponse], NetworkError>) -> Void) {
        network.request(MenuItemEndpoint()) { (response: Result<[MenuItemResponse], Error>) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure:
                completion(.failure(NetworkError.networkError))
            }
        }
    }
}
