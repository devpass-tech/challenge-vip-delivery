//
//  SampleApiDataSource.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation

final class SampleApiDataSource: SampleDataSource {

    private let network: NetworkManagerProtocol

    init(network: NetworkManagerProtocol) {
        self.network = network
    }

    func fetchData(completion: @escaping (Result<DataModel, Error>) -> Void) {

    }
}
