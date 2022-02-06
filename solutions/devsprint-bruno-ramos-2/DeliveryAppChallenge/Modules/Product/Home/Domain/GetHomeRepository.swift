//
//  HomeRepository.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

typealias GetHomeCompletion = (Result<Home, Error>) -> Void

/// Protocol used to be an interface that contains what data we can get
protocol GetHomeRepository {
    func getHomeRestaurants(completion: @escaping GetHomeCompletion)
}
