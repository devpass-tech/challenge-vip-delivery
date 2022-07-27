//
//  GetDataUseCase.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation

protocol GetSampleUseCase {
    func execute(completion: @escaping (Result<DataModel, Error>) -> Void)
}

final class GetData {
    private let repository: SampleRepository

    init(repository: SampleRepository) {
        self.repository = repository
    }
}

extension GetData: GetSampleUseCase {
    func execute(completion: @escaping (Result<DataModel, Error>) -> Void) {
    }
}
