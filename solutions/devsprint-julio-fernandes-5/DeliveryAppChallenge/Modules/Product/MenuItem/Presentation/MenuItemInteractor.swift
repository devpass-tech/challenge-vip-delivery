//
//  MenuItemInteractor.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 29/07/22.
//

import Foundation

final class MenuItemInteractor {     
    let presenter: MenuItemPresenterProtocol
    let useCase: MenuItemUseCaseProtocol
    
    init(presenter: MenuItemPresenterProtocol, useCase: MenuItemUseCaseProtocol) {
       self.presenter = presenter
        self.useCase = useCase
   }
}

extension MenuItemInteractor: MenuItemInteractorProtocol {
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
