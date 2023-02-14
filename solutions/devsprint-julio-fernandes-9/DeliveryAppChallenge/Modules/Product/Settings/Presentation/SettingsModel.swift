//
//  SettingsModel.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum SettingsModel {
    
    enum Request {
        case fetchDataView
    }
    
    enum Response {
        case fetchDataView(response: SettingsNetworkResponse)
        case fetchDataViewWithError(message: String)
    }
    
    enum ViewModel {
        case dataView(entity: SettingsNetworkResponse)
        case dataViewWithError(messageError: String)
    }
    
    enum Route {
        case goToEditAddress
    }
}
