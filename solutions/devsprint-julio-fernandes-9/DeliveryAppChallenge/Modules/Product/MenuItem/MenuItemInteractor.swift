//
//  MenuItemInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 21/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol MenuItemBusinessLogic {
    func doRequest(_ request: MenuItemModel.Request)
}

final class MenuItemInteractor {
    
    private let presenter: MenuItemPresentationLogic
    private let network: NetworkManager
    
    init(presenter: MenuItemPresentationLogic, network: NetworkManager) {
        self.presenter = presenter
        self.network = network
    }
}


// MARK: - MenuItemBusinessLogic
extension MenuItemInteractor: MenuItemBusinessLogic {
    
    func doRequest(_ request: MenuItemModel.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            switch request {
            case .fetchMenuItem:
                self.fetchMenuItem()
            }
        }
    }
}


// MARK: - Private Zone
private extension MenuItemInteractor {
    
    func fetchMenuItem() {
        network.request(DeliveryNetworkRequest.menuItem) { [weak self] (result: Result<MenuItemResponse, Error>) in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.presenter.presentResponse(.hasMenuItem(item: response))
            case .failure(let error):
                self.presenter.presentResponse(.erroMenuItem(error: error))
            }
        }
    }
}
