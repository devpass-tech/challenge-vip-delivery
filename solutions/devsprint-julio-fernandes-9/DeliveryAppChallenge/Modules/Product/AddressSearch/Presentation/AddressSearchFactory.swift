//
//  AddressSearchFactory.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 11/02/23.
//

import UIKit

enum AddressSearchControllerFactory {

    static func make(delegate: HomeDisplayLogic?) -> AddressSearchViewController {
        let presenter = AddressSearchPresenter()

        let network = NetworkManager()
        let remoteLoader = RemoteAddressSearchLoader(networking: network)
        let localLoader = LocalAddressSearchLoader()
        let loaderDecorator = AddressSearchLoaderDecorator(decoratee: remoteLoader,
                                                                 local: localLoader)
        let interactor = AddressSearchInteractor(presenter: presenter,
                                                 remoteLoader: loaderDecorator,
                                                 localLoader: localLoader)

        let router = AddressSearchRouter()
        let addressListView = AddressListView()
        let controller = AddressSearchViewController(addressListView: addressListView,
                                                     router: router,
                                                     delegate: delegate,
                                                     interactor: interactor)

        router.viewController = controller
        presenter.controller = controller

        return controller
    }

}
