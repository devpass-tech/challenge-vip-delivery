//
//  HomeWorker.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 30/01/22.
//

import Foundation

typealias HomeWorkingCompletion = (Result<String, Error>) -> Void

/// Protocol used to intermediate Worker and Interactor comunication
protocol HomeWorking {
    func fetchData(completion: @escaping HomeWorkingCompletion)
}

/// Class used to handle data request from Interactor to data repository (API/ DataBase)
final class HomeWorker: HomeWorking {
    private let network: NetworkManagerProtocol

    init(network: NetworkManagerProtocol) {
        self.network = network
    }

    func fetchData(completion: @escaping HomeWorkingCompletion) {
        completion(.success("Success"))
    }
}
