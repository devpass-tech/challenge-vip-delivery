//
//  HomeCacheDataSource.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

final class HomeCacheDataSource: HomeDataSource {
    private var cache: Home = []

    func fetchHomeData(completion: @escaping HomeDataSouceCompletion) {
        guard !cache.isEmpty else {
            return completion(.failure(EmptyCache()))
        }

        completion(.success(cache))
    }
}
