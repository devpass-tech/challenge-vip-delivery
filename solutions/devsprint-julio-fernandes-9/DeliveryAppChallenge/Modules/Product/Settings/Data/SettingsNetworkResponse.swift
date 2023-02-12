//
//  SettingsNetworkResponse.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

struct SettingsNetworkResponse: Codable {
    let name, email, address, paymentMethod: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case address = "address"
        case paymentMethod = "payment_method"
    }
}
