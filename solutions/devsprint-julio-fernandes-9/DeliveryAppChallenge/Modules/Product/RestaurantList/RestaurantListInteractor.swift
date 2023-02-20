//
//  RestaurantListInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 19/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol RestaurantListBusinessLogic {
    
    func doRequest(_ request: RestaurantListModel.Request)
}

final class RestaurantListInteractor {
    
    private let presenter: RestaurantListPresentationLogic
    private let network: NetworkManager
    
    init(presenter: RestaurantListPresentationLogic, network: NetworkManager) {
        self.presenter = presenter
        self.network = network
    }
}


// MARK: - RestaurantListBusinessLogic
extension RestaurantListInteractor: RestaurantListBusinessLogic {
    
    func doRequest(_ request: RestaurantListModel.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            switch request {
            case .fetchRestaurantList(let category):
                self.fetchDataView(category: category)
            }
        }
    }
}


// MARK: - Private Zone
private extension RestaurantListInteractor {
    
    func fetchDataView(category: String) {
        network.request(DeliveryNetworkRequest.allRestaurants) { [weak self] (result: Result<[Restaurant], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.presenter.presentResponse(.dataRestaurantList(response: response, category: category))
            case .failure(let error):
                self.presenter.presentResponse(.errorRequest(error: error))
            }
        }
    }
}
