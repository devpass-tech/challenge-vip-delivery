//
//  HomeViewPresenter.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

final class HomeViewPresenter {
    weak var controller: HomeViewControllerOutput?
}

extension HomeViewPresenter: HomeViewPresenterProtocol {
    func fetchedSuccessData() {
        controller?.showData()
    }
    
    func fetchedErrorData() {
        controller?.showError()
    }
}
