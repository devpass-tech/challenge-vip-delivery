//
//  GetSettingsUseCase.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import Foundation

protocol GetSettingsUseCase {
    func execute(completion: @escaping (Result<SettingsDataModel, Error>) -> Void)
}

final class GetSettings {
    
    private let repository: SettingsRepository
    
    init(repository: SettingsRepository) {
        self.repository = repository
    }
}

extension GetSettings: GetSettingsUseCase {
    
    func execute(completion: @escaping (Result<SettingsDataModel, Error>) -> Void) {}
}
