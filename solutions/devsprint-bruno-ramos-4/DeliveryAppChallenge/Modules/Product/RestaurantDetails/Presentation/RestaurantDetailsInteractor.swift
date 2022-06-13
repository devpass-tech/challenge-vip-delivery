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

final class RestaurantDetailsInteractor {
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
