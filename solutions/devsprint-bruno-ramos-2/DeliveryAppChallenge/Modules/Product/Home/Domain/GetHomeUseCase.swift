//
//  File.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

/// Protocol  with first Home module data request
/// Should return all restaurants from api
protocol GetHomeRestaurantsUseCase {
    func execute(completion: @escaping GetHomeRestaurantsCompletion)
}

/// Class that contains the repository and conforms to UseCase protocol to get requested data
final class GetHomeRestaurants {
    let repository: GetHomeRestaurantsRepository

    init(repository: GetHomeRestaurantsRepository) {
        self.repository = repository
    }
}

extension GetHomeRestaurants: GetHomeRestaurantsUseCase {
    func execute(completion: @escaping GetHomeRestaurantsCompletion) {
        repository.getHomeRestaurants(completion: completion)
    }
}
