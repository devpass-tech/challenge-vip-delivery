//
//  MenuItemProtocols.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 29/07/22.
//

import Foundation

protocol MenuItemInteractorProtocol {
    func fetchData()
}

protocol MenuItemPresenterProtocol {
    func fetchedSuccessData()
    func fetchedErrorData()
}

protocol MenuItemViewControllerOutput: AnyObject {
    func showData()
    func showError()
}
