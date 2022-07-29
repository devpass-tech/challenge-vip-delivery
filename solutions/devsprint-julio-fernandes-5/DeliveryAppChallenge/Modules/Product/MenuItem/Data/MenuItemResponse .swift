//
//  MenuItemResponse .swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 29/07/22.
//

import Foundation

struct MenuItemResponse: Decodable {
    let name: String
    let description: String
    let price: Double
}
