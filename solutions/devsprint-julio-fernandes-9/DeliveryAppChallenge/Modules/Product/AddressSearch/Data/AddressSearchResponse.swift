//
//  AddressSearchResponse.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 12/02/23.
//

import Foundation

typealias FullAddress = (streetWithNumber: String, neighborhood: String)

struct Address: Codable {
    let street: String
    let number: String
    let neighborhood: String
}

extension Address {
    func getFullAddress() -> FullAddress {
        FullAddress(streetWithNumber: "\(street), \(number)", neighborhood: neighborhood)
    }
}
