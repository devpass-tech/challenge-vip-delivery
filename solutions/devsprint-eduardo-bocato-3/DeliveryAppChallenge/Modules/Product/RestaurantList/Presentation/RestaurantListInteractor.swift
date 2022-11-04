//
//  RestaurantListInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 04/11/22.
//

import Foundation

protocol RestaurantListBusinessLogic {
    func fetchData(request: RestaurantList.FetchRestaurants.Request)
}

protocol RestaurantListDataStore {

}

final class RestaurantListInteractor:  RestaurantListDataStore {
    private let presenter:  RestaurantListPresentationLogic
    private let getRestaurantsUseCase: GetRestaurantsUseCase

    init(
        presenter:  RestaurantListPresentationLogic,
        getRestaurantsUseCase: GetRestaurantsUseCase
    ) {
        self.presenter = presenter
        self.getRestaurantsUseCase = getRestaurantsUseCase
    }
}

extension RestaurantListInteractor: RestaurantListBusinessLogic {
    func fetchData(request: RestaurantList.FetchRestaurants.Request) {
        getRestaurantsUseCase.execute() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.presenter.presentData(response: .init(data: data))
            case .failure(let error):
                self.presenter.presentError(response: .init(error: error))
            }

        }
    }
}
