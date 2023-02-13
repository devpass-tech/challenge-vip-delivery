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
        let interactor = AddressSearchInteractor()
        let presenter = AddressSearchPresenter()
        let controller = AddressSearchViewController(with: addressListView, and: interactor)

        interactor.presenter = presenter
        presenter.controller = controller

        return controller
    }

}
