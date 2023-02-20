//
//  HomeInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic {
    func doRequest(_ request: HomeModel.Request)
}

final class HomeInteractor {
    
    private let networking: NetworkManagerProtocol
    private let presenter: HomePresentationLogic
    
    init(networking: NetworkManagerProtocol, presenter: HomePresentationLogic) {
        self.networking = networking
        self.presenter = presenter
    }
}

// MARK: - HomeBusinessLogic
extension HomeInteractor: HomeBusinessLogic {
    
    func doRequest(_ request: HomeModel.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            switch request {
            case .fetchDataView:
                self.fetchDataView()
            }
        }
    }
}

// MARK: - Private Zone
private extension HomeInteractor {
    
    func fetchDataView() {
        networking.request(DeliveryNetworkRequest.allRestaurants) { [weak self] (result: Result<[Restaurant], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.presenter.presentResponse(.hasDataView(response: response))
            case .failure:
                self.presenter.presentResponse(.errorFetchDataView(message: "Houve erro no Request"))
            }
        }
    }
}
