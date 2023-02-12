//
//  AddressSearchFactory.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 11/02/23.
//

import UIKit

final class AddressSearchControllerFactory {

    private let addressListView: AddressListViewProtocol
    private let interactor: AddressSearchInteractorProtocol
    private let presenter: AddressSearchPresenterProtocol

    init(with addressListView: AddressListViewProtocol = AddressListView(),
         interactor: AddressSearchInteractorProtocol = AddressSearchInteractor(),
         and presenter: AddressSearchPresenterProtocol = AddressSearchPresenter()
    ) {
        self.addressListView = addressListView
        self.interactor = interactor
        self.presenter = presenter
    }

    func makeViewController() -> UIViewController {
        interactor.presenter = presenter

        let controller = AddressSearchViewController(with: addressListView, and: interactor)

        presenter.controller = controller

        return controller
    }

}
