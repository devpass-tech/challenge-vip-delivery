//
//  RestaurantDetailsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import Foundation

protocol RestaurantDetailsBusinessLogic {
    func requestFetchRestaurantMenu(request: RestaurantDetailsUseCases.FetchMenu.Request)
}

protocol RestaurantDetailsDataStore {}

final class RestaurantDetailsInteractor: RestaurantDetailsDataStore {
    private let presenter: RestaurantDetailsPresentationLogic
    private let worker: RestaurantDetailsWorking
    
    //MARK: - Inits
    
    init(
        presenter: RestaurantDetailsPresentationLogic,
        worker: RestaurantDetailsWorking
    ) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: - RestaurantDetailsBusinessLogic Extension

extension RestaurantDetailsInteractor: RestaurantDetailsBusinessLogic {
    func requestFetchRestaurantMenu(request: RestaurantDetailsUseCases.FetchMenu.Request) {
        worker.fetchData { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let restaurantDetails):
                self.presenter.presentRestaurantMenu(response: .success(restaurantDetails))
            case .failure(_):
                self.presenter.presentRestaurantMenu(response: .failure(APIError.networkError))
            }
        }
    }
}

