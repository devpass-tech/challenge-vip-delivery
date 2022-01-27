//
//  RestaurantListPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 25/01/22.
//

import Foundation

protocol RestaurantListPresentationLogic {}

final class RestaurantListPresenter {
    
    weak var viewController: RestaurantListDisplayLogic?
}

// MARK: - Presentation Logic
extension RestaurantListPresenter: RestaurantListPresentationLogic {}
