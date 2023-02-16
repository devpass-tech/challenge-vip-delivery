//
//  SettingsRouter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol SettingsRouting {
    func routeTo(_ route: SettingsModel.Route)
}

final class SettingsRouter {
    weak var viewController: UIViewController?
}


// MARK: - SettingsRouting
extension SettingsRouter: SettingsRouting {
    
    func routeTo(_ route: SettingsModel.Route) {
        DispatchQueue.main.async {
            switch route {
            case .goToEditAddress:
                self.showEditAddress()
            }
        }
    }
}


// MARK: - Private Zone
private extension SettingsRouter {
    
    func showEditAddress() {
        // TODO: Finish implementation
        viewController?.navigationController?.pushViewController(AddressSearchControllerFactory.make(delegate: nil), animated: true)
    }
}
