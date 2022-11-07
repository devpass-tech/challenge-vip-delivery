//
//  Settings.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 07/11/22.
//

import Foundation

struct Settings {
    var name: String
    var email: String
    var address: String
    var paymentMethod: String
    
    enum Sections: Int, CaseIterable {
        case name
        case email
        case address
        case paymentMethod

        var name: String {
            switch self {
            case .name:
                return "Name"
            case .email:
                return "Email"
            case .address:
                return "Address"
            case .paymentMethod:
                return "Payment Method"
            }
        }
    }
}
