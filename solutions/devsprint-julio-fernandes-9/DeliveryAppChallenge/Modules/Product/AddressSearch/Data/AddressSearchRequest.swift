//
//  AddressSearchRequest.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 12/02/23.
//

import Foundation

enum AddressSearchRequest: NetworkRequest {

    case fetchAllAdresses

    var pathURL: String {
        return "address_search_results.json"
    }
    var method: HTTPMethod {
        return .get
    }

}
