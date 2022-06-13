//
//  RestaurantDetailsPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 07/06/22.
//

import Foundation

protocol RestaurantDetailsPresentationLogic {
    func presentData(response: RestaurantDetails.Response)
}

final class RestaurantDetailsPresenter {
    weak var viewController: RestaurantDetailsDisplayLogic?
}

extension RestaurantDetailsPresenter: RestaurantDetailsPresentationLogic {
    func presentData(response: RestaurantDetails.Response) {
        viewController?.displayData(viewModel: .init())
    }
}
