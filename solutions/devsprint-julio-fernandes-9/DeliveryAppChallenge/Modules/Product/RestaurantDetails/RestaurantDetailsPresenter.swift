//
//  RestaurantDetailsPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 20/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol RestaurantDetailsPresentationLogic {
    func presentResponse(_ response: RestaurantDetailsModel.Response)
}

final class RestaurantDetailsPresenter {
    weak var viewController: RestaurantDetailsDisplayLogic?
}


// MARK: - RestaurantDetailsPresentationLogic
extension RestaurantDetailsPresenter: RestaurantDetailsPresentationLogic {
    
    func presentResponse(_ response: RestaurantDetailsModel.Response) {
        switch response {
        case .hasRestaurantDetail(let response):
            self.presentRestaurantDetail(response: response)
        case .errorRestaurantDetail(let error):
            self.presentMessageError(error: error)
        }
    }
}


// MARK: - Private Zone
private extension RestaurantDetailsPresenter {
    
    func presentRestaurantDetail(response: Restaurant) {
        self.viewController?.displayViewModel(.viewModel(restaurant: response))
    }
    
    func presentMessageError(error: Error) {
        let message = (error as? NetworkError)?.errorDescription
        self.viewController?.displayViewModel(.viewModelWithError(messageError: "Erro ao buscar: \(String(describing: message))"))
    }
}
