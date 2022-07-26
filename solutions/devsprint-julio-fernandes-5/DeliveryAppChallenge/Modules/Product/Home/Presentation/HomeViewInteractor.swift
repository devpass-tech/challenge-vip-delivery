//
//  HomeViewInteractor.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

final class HomeViewInteractor {
    
    let presenter: HomeViewPresenterProtocol
    let useCase: HomeViewUseCaseProtocol
    
    init(presenter: HomeViewPresenterProtocol, useCase: HomeViewUseCaseProtocol) {
        self.presenter = presenter
        self.useCase = useCase
    }
    
}

extension HomeViewInteractor: HomeViewInteractorProtocol {
    func fetchData() {
        // Chama o caso de uso 
        useCase.execute { [weak self] result in
            switch result {
            case .success: self?.presenter.fetchedSuccessData()
            case .failure: self?.presenter.fetchedErrorData()
            }
        }
    }
}
