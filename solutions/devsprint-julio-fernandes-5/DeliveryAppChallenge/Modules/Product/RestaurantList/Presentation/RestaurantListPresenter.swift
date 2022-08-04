//
//  RestaurantListPresenter.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

import Foundation

final class RestaurantListPresenter {
    weak var viewController: RestaurantListViewControllerOutput?
}

extension RestaurantListPresenter: RestaurantListPresenterProtocol {
    func fetchedSuccessData(_ data: [RestaurantListResponse]) {
        viewController?.showData(data)
    }
    
    func fetchedErrorData() {
        viewController?.showError()
    }
}
