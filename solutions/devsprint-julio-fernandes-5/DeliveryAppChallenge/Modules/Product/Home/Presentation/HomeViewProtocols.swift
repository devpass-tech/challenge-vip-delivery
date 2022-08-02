//
//  HomeViewProtocols.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

protocol HomeViewInteractorProtocol {
    func fetchData()
}

protocol HomeViewPresenterProtocol {
    func fetchedSuccessData(_ data: RestaurantDetailResponse.HomeViewModel)
    func fetchedErrorData()
}

protocol HomeViewControllerOutput: AnyObject {
    func showData(_ data: RestaurantDetailResponse.HomeViewModel)
    func showError()
}
