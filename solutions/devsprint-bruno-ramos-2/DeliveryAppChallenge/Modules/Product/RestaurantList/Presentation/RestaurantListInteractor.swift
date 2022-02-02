//
//  RestaurantListInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 25/01/22.
//

import Foundation

protocol RestaurantListBusinessLogic {
    func fetchRestaurantList(request: RestaurantListUseCases.FetchData.Request)
}

protocol RestaurantListDataStore {
    var restaurantId: String? { get set }
}

final class RestaurantListInteractor: RestaurantListDataStore {
    
    private let presenter: RestaurantListPresentationLogic
    private let worker: RestaurantListWorking
    var restaurantId: String?
    
    // MARK: - Initializers
    init(presenter: RestaurantListPresentationLogic,
         worker: RestaurantListWorking) {
        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: - Business Logic
extension RestaurantListInteractor: RestaurantListBusinessLogic {
    
    func fetchRestaurantList(request: RestaurantListUseCases.FetchData.Request) {
        worker.fetchRestaurantList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let restaurantList):
                self.presenter.presentFetchedRestaurantList(response: .success(restaurantList))
            case .failure(let error):
                self.presenter.presentFetchedRestaurantList(response: .failure(error))
            }
        }
    }
}
