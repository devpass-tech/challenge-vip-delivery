//
//  MenuItemEndpoint.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 29/07/22.
//

import Foundation

struct MenuItemEndpoint: NetworkRequest {
    var pathURL: String = "menu_item_details.json"
    var method: HTTPMethod = .get
}

