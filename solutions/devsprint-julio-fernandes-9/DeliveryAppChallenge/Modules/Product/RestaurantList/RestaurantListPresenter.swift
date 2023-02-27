//
//  RestaurantListPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 19/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol RestaurantListPresentationLogic {
    func presentResponse(_ response: RestaurantListModel.Response)
}

final class RestaurantListPresenter {
    public weak var viewController: RestaurantListDisplayLogic?
}

// MARK: - RestaurantListPresentationLogic
extension RestaurantListPresenter: RestaurantListPresentationLogic {
    
    func presentResponse(_ response: RestaurantListModel.Response) {
        switch response {
        case .dataRestaurantList(let response, let category):
            self.presentViewModel(response: response, category: category)
        case .errorRequest(let error):
            self.presentViewModelWithError(error: error)
        }
    }
}

// MARK: - Private Zone
private extension RestaurantListPresenter {
    
    func presentViewModel(response: [Restaurant], category: String) {
        let restaurants = response.filter({ $0.category.elementsEqual(category)})
        viewController?.displayViewModel(.restaurantList(list: restaurants))
    }
    
    func presentViewModelWithError(error: Error) {
        let message = (error as? NetworkError)?.errorDescription
        viewController?.displayViewModel(.fetchError(message: "Erro ao buscar: \(String(describing: message))"))
    }
}
