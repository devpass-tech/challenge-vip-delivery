//
//  HomeRouter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol HomeRouting {
    func routeTo(_ route: HomeModel.Route)
}

final class HomeRouter {
    public weak var viewController: UIViewController?
}


// MARK: - HomeRouting
extension HomeRouter: HomeRouting {
    
    func routeTo(_ route: HomeModel.Route) {
        DispatchQueue.main.async {
            switch route {
            case .dismissHomeScene:
                self.dismissHomeScene()
            case .goToSettings:
                self.goToSettings()
            case .showMessageError(let message):
                self.showAlertError(message: message)
            case .goToRestaurantList(let category):
                self.showRestaurantList(category: category)
            case .goToRestaurantDetail:
                self.showRestaurantDetail()
            case .goToEditAddress:
                self.showEditAddress()
            }
        }
    }
}


// MARK: - Private Zone
private extension HomeRouter {
    
    private func dismissHomeScene() {
        viewController?.dismiss(animated: true)
    }
    
    private func goToSettings() {
        viewController?.navigationController?.pushViewController(SettingsConfigurator.makeSettings(), animated: true)
    }
    
    private func showAlertError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(action)
        self.viewController?.navigationController?.present(alertController, animated: true)
    }
    
    private func showRestaurantList(category: String) {
        self.viewController?.navigationController?.pushViewController(RestaurantListConfigurantor.make(categoryFilter: category), animated: true)
    }
    
    private func showRestaurantDetail() {
        self.viewController?.navigationController?.pushViewController(RestaurantDetailsViewController(), animated: true)
    }
    
    private func showEditAddress() {
        self.viewController?.navigationController?.pushViewController(AddressSearchControllerFactory.make(), animated: true)
    }
}
