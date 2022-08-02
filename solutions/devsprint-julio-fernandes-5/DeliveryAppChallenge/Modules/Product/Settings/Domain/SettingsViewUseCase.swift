//
//  SettingsViewUseCase.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import Foundation


protocol SettingsViewUseCaseProtocol {
    func execute(completion: @escaping (Result<SettingsViewResponse, Error>) -> Void)
}

final class SettingsViewUseCase {
    private let repository: SettingsViewRepositoryProtocol

    init(repository: SettingsViewRepositoryProtocol) {
        self.repository = repository
    }
}

extension SettingsViewUseCase: SettingsViewUseCaseProtocol {
    func execute(completion: @escaping (Result<SettingsViewResponse, Error>) -> Void) {
        repository.fetchData { result in
            switch result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(.failure(error))
            }
        }
    }
}
