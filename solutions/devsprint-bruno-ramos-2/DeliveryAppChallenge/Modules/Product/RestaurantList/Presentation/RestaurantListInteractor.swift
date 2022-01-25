//
//  RestaurantListInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 25/01/22.
//

import Foundation

protocol RestaurantListBusinessLogic {}

protocol RestaurantListDataStore {}

final class RestaurantListInteractor: RestaurantListDataStore {
    
    private let presenter: RestaurantListPresentationLogic
    
    // MARK: - Initializers
    init(presenter: RestaurantListPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - Business Logic
extension RestaurantListInteractor: RestaurantListBusinessLogic {}
