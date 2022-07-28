//
//  RestaurantListInteractor.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

import Foundation

final class RestaurantListInteractor {
    
    let presenter: RestaurantListPresenterProtocol
    let useCase: RestaurantListUseCaseProtocol
    
    init(presenter: RestaurantListPresenterProtocol, useCase: RestaurantListUseCaseProtocol) {
       self.presenter = presenter
       self.useCase = useCase
   }
}

extension RestaurantListInteractor: RestaurantListInteractorProtocol {
    func fetchData() {
        useCase.execute { [weak self] result in
            switch result {
            case .success:
                self?.presenter.fetchedSuccessData()
            case .failure:
                self?.presenter.fetchedErrorData()
            }
        }
    }
}
