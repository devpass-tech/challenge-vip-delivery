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
    func fetchedSuccessData() {
        viewController?.showData()
    }
    
    func fetchedErrorData() {
        viewController?.showError()
    }
}
