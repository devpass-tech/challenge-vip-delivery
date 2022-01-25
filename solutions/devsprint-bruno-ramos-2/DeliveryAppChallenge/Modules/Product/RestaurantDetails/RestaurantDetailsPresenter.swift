//
//  RestaurantDetailsPresenter.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import Foundation

protocol RestaurantDetailsPresentationLogic {}

final class RestaurantDetailsPresenter {
    weak var viewController: RestaurantDetailsDisplayLogic?
}

//MARK: - RestaurantDetailsPresentationLogic Extension

extension RestaurantDetailsPresenter: RestaurantDetailsPresentationLogic {}
