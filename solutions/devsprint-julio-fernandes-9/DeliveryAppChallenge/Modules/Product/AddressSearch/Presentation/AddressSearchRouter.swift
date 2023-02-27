//
//  AddressSearchRouter.swift
//  DeliveryApp
//
//  Created by Renato F. dos Santos Jr on 16/02/23.
//

import Foundation
import UIKit

protocol AddressSearchRoutingProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func routeTo(_ route: AddressSearchModel.Route)
}

final class AddressSearchRouter: AddressSearchRoutingProtocol {

    weak var viewController: UIViewController?

    func routeTo(_ route: AddressSearchModel.Route) {
        DispatchQueue.main.async {
            switch route {
            case .goToHome:
                self.goToHome()
            case let .showAllertError(message):
                self.showAllertError(message)
            }
        }
    }

}

private extension AddressSearchRouter {
    private func goToHome() {
        viewController?.navigationController?.pushViewController(HomeConfigurator.makeHome(), animated: true)
    }

    private func showAllertError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(action)
        self.viewController?.navigationController?.present(alertController, animated: true)
    }
}
