//
//  AddressListViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 13/02/23.
//

import Foundation

struct AddressListViewModel {
    var title: String
    var subtitle: String
}

extension AddressListViewModel {
    func toString() -> String {
        "\(title). \(subtitle)"
    }
}
