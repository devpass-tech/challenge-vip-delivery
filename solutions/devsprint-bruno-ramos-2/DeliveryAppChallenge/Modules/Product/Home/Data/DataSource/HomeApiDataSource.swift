//
//  HomeApiDataSource.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

final class HomeApiDataSource {
    private let network: NetworkManagerProtocol

    init(network: NetworkManagerProtocol) {
        self.network = network
    }
}

extension HomeApiDataSource: HomeDataSource {
    func fetchHomeData(completion: @escaping HomeDataSouceCompletion) {
        let request = HomeRequest()

        network.request(request, completion: {(result: Result <HomeResponse, Error>) in
            switch result {
            case .success(let homeResponse):
                completion(.success(.init(from: homeResponse)))
            case .failure(let error):
                completion(.failure(error))
            } 
        })
    }
}
