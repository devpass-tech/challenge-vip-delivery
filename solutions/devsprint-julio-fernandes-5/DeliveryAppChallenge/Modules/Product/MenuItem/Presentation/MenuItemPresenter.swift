//
//  MenuItemPresenter.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 29/07/22.
//

import Foundation

final class MenuItemPresenter {
    weak var viewController: MenuItemViewControllerOutput?
}

extension MenuItemPresenter: MenuItemPresenterProtocol {
    func fetchedSuccessData() {
        viewController?.showData()
    }
    
    func fetchedErrorData() {
        viewController?.showError()
    }
}
