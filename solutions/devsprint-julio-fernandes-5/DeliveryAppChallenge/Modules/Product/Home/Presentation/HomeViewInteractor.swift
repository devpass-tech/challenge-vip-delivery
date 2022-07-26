//
//  HomeViewInteractor.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

final class HomeViewInteractor {
    
    let presenter: HomeViewPresenterProtocol
    
    init(presenter: HomeViewPresenterProtocol) {
        self.presenter = presenter
    }
    
}

extension HomeViewInteractor: HomeViewInteractorProtocol {
    
}
