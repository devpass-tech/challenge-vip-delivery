//
//  AddressSearchFactory.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 11/02/23.
//

import UIKit

enum AddressSearchControllerFactory {

    static func make() -> AddressSearchViewController {
        let addressListView = AddressListView()
        let presenter = AddressSearchPresenter()
        let network = NetworkManager()
        let interactor = AddressSearchInteractor(with: presenter, and: network)
        let controller = AddressSearchViewController(with: addressListView, and: interactor)

        presenter.controller = controller

        return controller
    }

}
