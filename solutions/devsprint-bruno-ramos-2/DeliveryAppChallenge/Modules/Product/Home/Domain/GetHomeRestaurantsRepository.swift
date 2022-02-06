//
//  HomeRepository.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

typealias GetHomeRestaurantsCompletion = (Result<Home, Error>) -> Void

/// Protocol used to be an interface that contains what data whe can get
protocol GetHomeRestaurantsRepository {
    func getHomeRestaurants(completion: @escaping GetHomeRestaurantsCompletion)
}
