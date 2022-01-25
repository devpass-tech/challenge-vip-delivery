//
//  RestaurantDetailsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import Foundation

protocol RestaurantDetailsBusinessLogic {}

protocol RestaurantDetailsDataStore {}

final class RestaurantDetailsInteractor: RestaurantDetailsDataStore {
    private let presenter: RestaurantDetailsPresentationLogic
    
    //MARK: - Inits
    
    init(presenter: RestaurantDetailsPresentationLogic) {
        self.presenter = presenter
    }
}

//MARK: - RestaurantDetailsBusinessLogic Extension

extension RestaurantDetailsInteractor: RestaurantDetailsBusinessLogic {}

