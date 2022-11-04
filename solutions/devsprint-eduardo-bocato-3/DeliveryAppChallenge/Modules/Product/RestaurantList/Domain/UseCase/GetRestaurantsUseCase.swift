//
//  GetRestaurantsUseCase.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 02/11/22.
//

import Foundation

protocol GetRestaurantsUseCase {
    func execute(completion: @escaping (Result<[Restaurant], GetRestaurantError>) -> Void)
}

final class GetRestaurantData {
    private let repository: RestaurantListRepository

    init(repository: RestaurantListRepository) {
        self.repository = repository
    }
}

extension GetRestaurantData: GetRestaurantsUseCase {
    func execute(completion: @escaping (Result<[Restaurant], GetRestaurantError>) -> Void) {
        guard let data = repository.getData() else {
            return completion(.failure(.noData))
        }
        let decoder = JSONDecoder()
        do {
            let restaurants = try decoder.decode([Restaurant].self, from: data)
            return completion(.success(restaurants))
        } catch {
            return completion(.failure(.invalidData))
        }
    }
}
