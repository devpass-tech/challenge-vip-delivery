//
//  HomeModel.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum HomeModel {
    
    enum Request {
        case fetchDataView
    }
    
    enum Response {
        case hasDataView(response: [Restaurant])
        case errorFetchDataView(message: String)
    }
    
    enum ViewModel {
        case dataView(viewEntity: HomeViewEntity)
        case dataViewWithError(messageError: String)
    }
    
    enum Route {
        case dismissHomeScene
        case goToSettings
        case showMessageError(message: String)
        case goToRestaurantList(category: String)
        case goToRestaurantDetail
        case goToEditAddress
    }
}
