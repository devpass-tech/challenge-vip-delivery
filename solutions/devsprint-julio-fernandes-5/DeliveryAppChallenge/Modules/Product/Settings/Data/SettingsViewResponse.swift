//
//  SettingsViewResponse.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import Foundation

struct SettingsViewResponse: Decodable {
    let name: String
    let email: String
    let address: String
    let paymentMethod: String

    private enum CodingKeys: String, CodingKey {
        case name, email, address
        case paymentMethod = "payment_method"
    }
}

