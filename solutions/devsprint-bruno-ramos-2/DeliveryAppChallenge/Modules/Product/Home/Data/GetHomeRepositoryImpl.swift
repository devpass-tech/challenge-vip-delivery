//
//  GetHomeRepositoryImpl.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

/// Class used to get data from data source (API/ DB/ UseDefaults/ ETC)
/// In this class we can implementa a cache strategy too
final class GetHomeRepositoryImpl {
    private let primaryDataSource: HomeDataSource
    private let secondaryDataSource: HomeDataSource

    init(primaryDataSource: HomeDataSource, secondaryDataSource: HomeDataSource) {
        self.primaryDataSource = primaryDataSource
        self.secondaryDataSource = secondaryDataSource
    }
}


extension GetHomeRepositoryImpl: GetHomeRepository {
    func getHomeRestaurants(completion: @escaping GetHomeCompletion) {
        primaryDataSource.fetchHomeData { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let home):
                completion(.success(home))
            case .failure(let error):
                switch error {
                case is EmptyCache:
                    self.secondaryDataSource.fetchHomeData(completion: completion)
                default:
                    completion(.failure(error))
                }
            }
        }
    }
}
