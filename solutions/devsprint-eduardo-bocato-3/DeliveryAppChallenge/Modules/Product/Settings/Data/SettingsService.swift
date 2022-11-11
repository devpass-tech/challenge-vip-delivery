//
//  SettingsService.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 11/11/22.
//

import Foundation

protocol SettingsServiceProtocol {
    func getSettings(completion: @escaping (Result<SettingsResponse, SettingsList.LoadSettings.Error>) -> Void)
}

final class SettingsService: SettingsServiceProtocol {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func getSettings(completion: @escaping (Result<SettingsResponse, SettingsList.LoadSettings.Error>) -> Void) {
        
        guard let data = jsonMockData else {
            completion(.failure(.noData))
            return
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(SettingsResponse.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(.parseFailure))
        }
    }
}

private extension SettingsServiceProtocol {
    
    var jsonMockData: Data? {
        """
        {
            "name": "John Appleseed",
            "email": "john@apple.com",
            "address": "Rua Bela Cintra, 495 - Consolação",
            "payment_method": "Cartão de Crédito"
        }
        """.data(using: .utf8)
    }
}
