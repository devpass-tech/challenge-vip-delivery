//
//  GetDataUseCase.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 08/06/22.
//

import Foundation

protocol GetRestaurantListUseCase {
    func execute(completion: @escaping (Result<DataModel, Error>) -> Void)
}

final class GetRestaurantList {
    private let repository: RestaurantListRepository

    init(repository: RestaurantListRepository) {
        self.repository = repository
    }
}

extension GetRestaurantList: GetRestaurantListUseCase {
    func execute(completion: @escaping (Result<DataModel, Error>) -> Void) {
    }
}
