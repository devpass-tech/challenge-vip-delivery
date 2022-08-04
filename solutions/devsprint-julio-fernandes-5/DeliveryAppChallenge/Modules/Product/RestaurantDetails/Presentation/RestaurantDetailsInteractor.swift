//
//  RestaurantDetailsInteractor.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 04/08/22.
//

import Foundation

final class RestaurantDetailsInteractor {
    
    let presenter: RestaurantDetailsPresenterProtocol
    let useCase: RestaurantDetailsUseCaseProtocol
    
    init(presenter: RestaurantDetailsPresenterProtocol, useCase: RestaurantDetailsUseCaseProtocol) {
        self.presenter = presenter
        self.useCase = useCase
    }
    
}

extension RestaurantDetailsInteractor: RestaurantDetailsInteractorProtocol {
    
    func fetchData() {
        useCase.execute { [presenter] result in
            switch result {
            case let .success(data): presenter.fetchedSuccessData(data)
            case .failure: presenter.fetchedErrorData()
            }
        }
    }
    
}
