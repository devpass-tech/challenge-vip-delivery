//
//  File.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

/// Protocol  with first Home module data request
/// Should return all restaurants from api
protocol GetHomeUseCase {
    func execute(completion: @escaping GetHomeCompletion)
}

/// Class that contains the repository and conforms to UseCase protocol to get requested data
final class GetHome {
    let repository: GetHomeRepository

    init(repository: GetHomeRepository) {
        self.repository = repository
    }
}

extension GetHome: GetHomeUseCase {
    func execute(completion: @escaping GetHomeCompletion) {
        repository.getHomeRestaurants(completion: completion)
    }
}
