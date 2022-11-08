//
//  MenuItemEntity.swift
//  DeliveryAppChallenge
//
//  Created by Aby Mathew on 08/11/22.
//

import Foundation

// Category MenuItemEntity Model
struct MenuItemEntity: Decodable {
    let name: String
    let description: String
    let price: Double
}

enum MenuItemErorr: Error {
    case categoryFetchingError
}
