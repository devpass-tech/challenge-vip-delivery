//
//  RestaurantListUseCase.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

import Foundation

protocol RestaurantListUseCaseProtocol {
    func execute(completion: @escaping (Result<RestaurantListResponse, Error>) -> Void)
}

final class RestaurantListUseCase {
    private let repository: RestaurantListRepositoryProtocol

        init(repository: RestaurantListRepositoryProtocol) {
            self.repository = repository
        }
}

extension RestaurantListUseCase: RestaurantListUseCaseProtocol {
    func execute(completion: @escaping (Result<RestaurantListResponse, Error>) -> Void) {
        repository.fetchData { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
