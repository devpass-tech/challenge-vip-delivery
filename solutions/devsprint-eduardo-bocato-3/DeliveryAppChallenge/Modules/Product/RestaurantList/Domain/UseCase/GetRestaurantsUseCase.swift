//
//  GetRestaurantsUseCase.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 02/11/22.
//

import Foundation

protocol GetRestaurantsUseCaseProtocol {
    func execute(completion: @escaping (Result<[Restaurant], GetRestaurantError>) -> Void)
}

final class GetRestaurantsUseCase {
    private let service: RestaurantListServiceProtocol

    init(service: RestaurantListServiceProtocol) {
        self.service = service
    }
}

extension GetRestaurantsUseCase: GetRestaurantsUseCaseProtocol {
    func execute(completion: @escaping (Result<[Restaurant], GetRestaurantError>) -> Void) {
        service.getItems { result in
            switch result {
            case .success(let restaurants):
                completion(.success(restaurants))
            case .failure(let failure):
                completion(.failure(.defaultError(message: "Error getting restaurants")))
            }
        }
    }
}
