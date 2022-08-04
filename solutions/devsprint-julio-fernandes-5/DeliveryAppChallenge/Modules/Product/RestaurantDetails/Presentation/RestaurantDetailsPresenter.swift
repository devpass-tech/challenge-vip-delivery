//
//  RestaurantDetailsPresenter.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 04/08/22.
//

import Foundation

final class RestaurantDetailsPresenter {
    weak var controller: RestaurantDetailsControllerOutput?
}

extension RestaurantDetailsPresenter: RestaurantDetailsPresenterProtocol {
    func fetchedSuccessData(_ data: RestaurantDetailViewModel) {
        controller?.showData(data)
    }
    
    func fetchedErrorData() {
        controller?.showError()
    }
}
