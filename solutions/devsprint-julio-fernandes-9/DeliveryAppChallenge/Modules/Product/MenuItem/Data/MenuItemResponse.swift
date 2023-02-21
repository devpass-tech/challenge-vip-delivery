//
//  MenuItemResponse.swift
//  DeliveryApp
//
//  Created by Alexandre Robaert on 21/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

struct MenuItemResponse: Codable, MenuItemModelProtocol {
    
    let name: String
    let description: String
    let price: Double
}
