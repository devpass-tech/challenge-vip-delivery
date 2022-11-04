//
//  RestaurantListPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 04/11/22.
//

import Foundation

protocol RestaurantListPresentationLogic {
    func presentData(response: RestaurantList.FetchRestaurants.Response)
    func presentError(response: RestaurantList.Error.Response)
}

final class RestaurantListPresenter {
    weak var viewController: RestaurantListDisplayLogic?
}

extension RestaurantListPresenter: RestaurantListPresentationLogic {
    func presentData(response: RestaurantList.FetchRestaurants.Response) {

        let viewModel = response.data

        viewController?.displayData(viewModel: .init(items: viewModel))
    }
    
    func presentError(response: RestaurantList.Error.Response) {
        
    }
}
