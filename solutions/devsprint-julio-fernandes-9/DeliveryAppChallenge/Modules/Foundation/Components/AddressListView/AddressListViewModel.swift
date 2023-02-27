//
//  AddressListViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 13/02/23.
//

import Foundation

struct AddressListViewModel {
    let title: String
    let subtitle: String
}

extension AddressListViewModel {
    func toString() -> String {
        "\(title). \(subtitle)"
    }
}
