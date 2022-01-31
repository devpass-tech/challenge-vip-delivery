//
//  NetworkRequest.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation

protocol NetworkRequest {
    var baseURL: String { get }
    var pathURL: String { get }
    var method: HTTPMethod { get }
}

enum HTTPMethod: String {
    case get
    case post
}

extension NetworkRequest {
    var baseURL: String {
        "https://raw.githubusercontent.com/devpass-tech/challenge-vip-delivery/main/api/"
    }
}
