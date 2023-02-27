//
//  SettingsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol SettingsBusinessLogic {
    func doRequest(_ request: SettingsModel.Request)
}

final class SettingsInteractor: SettingsBusinessLogic {
    
    private let presenter: SettingsPresentationLogic
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol, presenter: SettingsPresentationLogic) {
        self.network = network
        self.presenter = presenter
    }
    
    func doRequest(_ request: SettingsModel.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            switch request {
            case .fetchDataView:
                self.fetchDataView()
            }
        }
    }
}

// MARK: - Private Zone
private extension SettingsInteractor {
    
    func fetchDataView() {
        
        network.request(DeliveryNetworkRequest.settings) { [weak self] (result: Result<SettingsNetworkResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.presenter.presentResponse(.fetchDataView(response: response))
            case .failure(let error):
                if let error = error as? NetworkError {
                    self.presenter.presentResponse(.fetchDataViewWithError(message: "Falha ao buscar dados: \(String(describing: error.errorDescription))"))
                }
            }
        }
    }
}
