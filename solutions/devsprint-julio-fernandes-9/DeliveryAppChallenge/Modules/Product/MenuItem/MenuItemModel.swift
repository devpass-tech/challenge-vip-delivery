//
//  MenuItemModel.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 21/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum MenuItemModel {
    
    enum Request {
        case fetchMenuItem
    }
    
    enum Response {
        case hasMenuItem(item: MenuItemModelProtocol)
        case erroMenuItem(error: Error)
    }
    
    enum ViewModel {
        case dataMenuItem(item: MenuItemModelProtocol)
        case presentAlertMessage(message: String)
    }
    
    enum Route {
        case goToAddCartMessage
        case goToMessageError(message: String)
    }
}
