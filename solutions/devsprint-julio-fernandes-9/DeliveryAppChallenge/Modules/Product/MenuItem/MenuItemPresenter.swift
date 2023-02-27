//
//  MenuItemPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 21/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol MenuItemPresentationLogic {
    func presentResponse(_ response: MenuItemModel.Response)
}

final class MenuItemPresenter {
    weak var viewController: MenuItemDisplayLogic?
}


// MARK: - MenuItemPresentationLogic
extension MenuItemPresenter: MenuItemPresentationLogic {
    
    func presentResponse(_ response: MenuItemModel.Response) {
        
        switch response {
        case .hasMenuItem(let item):
            viewController?.displayViewModel(.dataMenuItem(item: item))
        case .erroMenuItem(let error):
            let message = (error as? NetworkError)?.errorDescription
            viewController?.displayViewModel(.presentAlertMessage(message: "Houve um erro na busca: \(String(describing: message))"))
        }
    }
}
