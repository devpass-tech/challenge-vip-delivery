//
//  RestaurantDetailsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 20/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol RestaurantDetailsBusinessLogic {
    func doRequest(_ request: RestaurantDetailsModel.Request)
}

final class RestaurantDetailsInteractor {
    
    private let network: NetworkManagerProtocol
    private let presenter: RestaurantDetailsPresentationLogic
    
    init(network: NetworkManagerProtocol, presenter: RestaurantDetailsPresentationLogic) {
        self.network = network
        self.presenter = presenter
    }
}


// MARK: - RestaurantDetailsBusinessLogic
extension RestaurantDetailsInteractor: RestaurantDetailsBusinessLogic {
    
    func doRequest(_ request: RestaurantDetailsModel.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            switch request {
            case .fetchRestaurantDetail:
                self.fetchRestaurantDetail()
            }
        }
    }
}

// MARK: - Private Zone
private extension RestaurantDetailsInteractor {
    
    func fetchRestaurantDetail() {
        network.request(DeliveryNetworkRequest.restaurantDetail) { [weak self] (result: Result<Restaurant, Error>) in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.presenter.presentResponse(.hasRestaurantDetail(response: response))
            case .failure(let error):
                self.presenter.presentResponse(.errorRestaurantDetail(error: error))
            }
        }
    }
}
