//
//  RestaurantListInteractor.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 08/06/22.
//

protocol RestaurantListBusinessLogic {
    func fetchData(request: RestaurantList.Request)
}

protocol RestaurantListDataStore {
    var restaurantId: Int? { get set }
}

final class RestaurantListInteractor:  RestaurantListDataStore {
    var restaurantId: Int?
    
    private let presenter:  RestaurantListPresentationLogic
    
    init(presenter:  RestaurantListPresentationLogic) {
        self.presenter = presenter
    }
}

extension RestaurantListInteractor: RestaurantListBusinessLogic {
    func fetchData(request: RestaurantList.Request) {
        presenter.presentData(response: .init())
    }
}
