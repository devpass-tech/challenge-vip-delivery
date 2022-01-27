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
    private let worker: RestaurantListWorking
    
    // MARK: - Initializers
    init(presenter: RestaurantListPresentationLogic,
         worker: RestaurantListWorking) {
        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: - Business Logic
extension RestaurantListInteractor: RestaurantListBusinessLogic {}
