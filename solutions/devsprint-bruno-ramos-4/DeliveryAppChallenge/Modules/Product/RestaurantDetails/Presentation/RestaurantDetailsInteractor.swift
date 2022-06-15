//
//  RestaurantDetailsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 07/06/22.
//

import Foundation

protocol RestaurantDetailsBusinessLogic {
    func loadRestaurantDetails()
}

final class RestaurantDetailsInteractor {
    private let presenter:  RestaurantDetailsPresentationLogic
    private let worker: RestaurantDetailsWorkerProtocol

    init(
        presenter:  RestaurantDetailsPresentationLogic,
        worker: RestaurantDetailsWorkerProtocol
    ) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension RestaurantDetailsInteractor: RestaurantDetailsBusinessLogic {
    
    func loadRestaurantDetails() {
        worker.loadRestaurantDetails { [weak self] (result: Result<RestaurantDetail, Error>) in
            switch result {
                case let .success(restaurantDetail):
                    self?.presenter.presentData(response: .success(restaurantDetail))
                    print(restaurantDetail)
                case let .failure(error):
                    self?.presenter.presentData(response: .failure(error))
                    print(error.localizedDescription)
            }
        }
    }
}
