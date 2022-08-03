//
//  SettingsViewRepository.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import Foundation

protocol SettingsViewRepositoryProtocol {
    func fetchData(completion: @escaping (Result<SettingsViewResponse, NetworkError>) -> Void)
}

final class SettingsViewRepository {

    let network: NetworkManagerProtocol

    init(network: NetworkManagerProtocol) {
        self.network = network
    }

}

extension SettingsViewRepository: SettingsViewRepositoryProtocol {
    func fetchData(completion: @escaping (Result<SettingsViewResponse, NetworkError>) -> Void) {
        network.request(SettingsViewEndpoint()) { (response: Result<SettingsViewResponse, Error>) in
            switch response {
            case let .success(data): completion(.success(data))
            case .failure: completion(.failure(NetworkError.networkError))
            }
        }
    }
}
