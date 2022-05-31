//
//  SampleRepositoryImpl.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation

final class SampleRepositoryImpl: SampleRepository {
    private let dataSource: SampleDataSource

    init(dataSource: SampleDataSource) {
        self.dataSource = dataSource
    }
}
