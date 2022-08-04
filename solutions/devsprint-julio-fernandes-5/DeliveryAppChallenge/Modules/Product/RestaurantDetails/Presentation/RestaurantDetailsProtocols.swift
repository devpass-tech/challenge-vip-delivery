//
//  RestaurantDetailsProtocols.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 04/08/22.
//

import Foundation

protocol RestaurantDetailsInteractorProtocol {
    func fetchData()
}

protocol RestaurantDetailsPresenterProtocol {
    func fetchedSuccessData(_ data: RestaurantDetailViewModel)
    func fetchedErrorData()
}

protocol RestaurantDetailsControllerOutput: AnyObject {
    func showData(_ data: RestaurantDetailViewModel)
    func showError()
}
