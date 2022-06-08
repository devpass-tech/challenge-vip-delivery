//
//  RestaurantDetailsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 07/06/22.
//

import Foundation

protocol RestaurantDetailsBusinessLogic {
    func loadRestaurantDetails(request: RestaurantDetails.Request)
}

protocol RestaurantDetailsDataStore { }

final class RestaurantDetailsInteractor:  RestaurantDetailsDataStore {
    private let presenter:  RestaurantDetailsPresentationLogic

    init(presenter:  RestaurantDetailsPresentationLogic) {
        self.presenter = presenter
    }
}

extension RestaurantDetailsInteractor: RestaurantDetailsBusinessLogic {
    func loadRestaurantDetails(request: RestaurantDetails.Request) {
        presenter.presentData(response: .init())
    }
}
