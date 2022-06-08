//
//  RestaurantListPresenter.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 08/06/22.
//

import Foundation

protocol RestaurantListPresentationLogic {
    func presentData(response: RestaurantList.Response)
}

final class RestaurantListPresenter {
    weak var viewController: RestaurantListDisplayLogic?
}

extension RestaurantListPresenter: RestaurantListPresentationLogic {

    func presentData(response: RestaurantList.Response) {
        viewController?.displayData(viewModel: .init())
    }
}
