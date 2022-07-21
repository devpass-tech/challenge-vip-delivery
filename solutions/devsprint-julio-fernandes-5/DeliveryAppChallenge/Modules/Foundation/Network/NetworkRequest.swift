//
//  NetworkRequest.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 18/04/22.
//

import Foundation

protocol NetworkRequest {
    var baseURL: String { get }
    var pathURL: String { get }
    var method: HTTPMethod { get }
}

enum HTTPMethod: String {
    case get
}

extension NetworkRequest {
    var baseURL: String {
        "https://raw.githubusercontent.com/devpass-tech/challenge-delivery-app/main/api/"
    }
}
