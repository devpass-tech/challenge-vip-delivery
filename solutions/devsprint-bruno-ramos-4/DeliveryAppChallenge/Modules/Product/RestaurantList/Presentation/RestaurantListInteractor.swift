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

}

final class RestaurantListInteractor: RestaurantListDataStore {
    private let worker: RestaurantListWorkerProtocol
    private let presenter: RestaurantListPresentationLogic
    
    init(presenter: RestaurantListPresentationLogic, worker: RestaurantListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension RestaurantListInteractor: RestaurantListBusinessLogic {
    func fetchData(request: RestaurantList.Request) {
        worker.fetchRestaurantList { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let restaurantList):
                self.presenter.presentData(response: .success(restaurantList))
            case .failure(let error):
                self.presenter.presentData(response: .failure(error))
            }
        }
    }
}
