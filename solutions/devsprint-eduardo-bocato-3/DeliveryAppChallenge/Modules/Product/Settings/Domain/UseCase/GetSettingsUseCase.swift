//
//  GetSettingsUseCase.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 11/11/22.
//

import Foundation

protocol GetSettingsUseCaseProtocol {
    func execute(completion: @escaping (Result<SettingsResponse, SettingsList.LoadSettings.Error>) -> Void)
}

final class GetSettingsUseCase: GetSettingsUseCaseProtocol {
    
    private let service: SettingsServiceProtocol
    
    init(service: SettingsServiceProtocol) {
        self.service = service
    }
    
    func execute(completion: @escaping (Result<SettingsResponse, SettingsList.LoadSettings.Error>) -> Void) {
        service.getSettings { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
