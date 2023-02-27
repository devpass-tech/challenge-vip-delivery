//
//  MenuItemRouter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 21/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol MenuItemRouting {
    func routeTo(_ route: MenuItemModel.Route)
}

final class MenuItemRouter {
    weak var viewController: UIViewController?
}


// MARK: - MenuItemRouting
extension MenuItemRouter: MenuItemRouting {
    
    func routeTo(_ route: MenuItemModel.Route) {
        DispatchQueue.main.async {
            switch route {
            case .goToAddCartMessage:
                self.showAddCardMessage()
            case .goToMessageError(let message):
                self.showCardMessage(messageError: message)
            }
        }
    }
}

// MARK: - Private Zone
private extension MenuItemRouter {
    
    func showAddCardMessage() {
        let alertController = UIAlertController(title: "Adicionado ao Carrinho!", message: "Seu item foi adicionado ao carrinho!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(action)
        self.viewController?.navigationController?.present(alertController, animated: true)
    }
    
    func showCardMessage(messageError: String) {
        let alertController = UIAlertController(title: "Falha ao buscar dados.", message: "messageError", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(action)
        self.viewController?.navigationController?.present(alertController, animated: true)
    }
}
