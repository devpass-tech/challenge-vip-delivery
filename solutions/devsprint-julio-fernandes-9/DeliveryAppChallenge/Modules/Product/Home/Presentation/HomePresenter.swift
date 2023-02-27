//
//  HomePresenter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol HomePresentationLogic {
    func presentResponse(_ response: HomeModel.Response)
}

final class HomePresenter {
    public weak var viewController: HomeDisplayLogic?
}

// MARK: - HomePresentationLogic
extension HomePresenter: HomePresentationLogic {
    
    func presentResponse(_ response: HomeModel.Response) {
        switch response {
        case .hasDataView(let response):
            presentViewModel(with: response)
        case .errorFetchDataView(let message):
            presentViewModel(with: message)
        }
    }
}

// MARK: - Private Zone
private extension HomePresenter {
    
    private func presentViewModel(with response: [Restaurant]) {
        let categories = Set(response.compactMap { $0.category })
        let viewEntity = HomeViewEntity(restaurantList: response, categories: categories)
        viewController?.displayViewModel(.dataView(viewEntity: viewEntity))
    }
    
    private func presentViewModel(with messageError: String) {
        viewController?.displayViewModel(.dataViewWithError(messageError: messageError))
    }
}
