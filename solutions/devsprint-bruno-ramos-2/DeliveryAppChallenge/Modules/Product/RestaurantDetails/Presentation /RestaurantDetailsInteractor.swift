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

protocol RestaurantDetailsDataStore: AnyObject {
    var restaurantId: String { get }
}

final class RestaurantDetailsInteractor: RestaurantDetailsDataStore {
    private let presenter: RestaurantDetailsPresentationLogic
    private let getRestaurantDetails: GetRestaurantDetailsUseCase
    let restaurantId: String
    
    //MARK: - Inits
    
    init(
        presenter: RestaurantDetailsPresentationLogic,
        getRestaurantDetails: GetRestaurantDetailsUseCase,
        restaurantId: String
    ) {
        self.presenter = presenter
        self.getRestaurantDetails = getRestaurantDetails
        self.restaurantId = restaurantId
    }
}

//MARK: - RestaurantDetailsBusinessLogic Extension

extension RestaurantDetailsInteractor: RestaurantDetailsBusinessLogic {
    func requestFetchRestaurantMenu(request: RestaurantDetailsUseCases.FetchMenu.Request) {
        getRestaurantDetails.execute(request: .init(restaurantId: restaurantId)) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let restaurantDetails):
                self.presenter.presentRestaurantMenu(response: .success(restaurantDetails))
            case .failure(let error):
                self.presenter.presentRestaurantMenu(response: .failure(error))
            }
        }
    }
}

