//
//  HomeViewEndpoint.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

/// Montamos nosso endpoint que contem os dados necessário para requisição
struct HomeViewEndpoint: NetworkRequest {
    var pathURL: String = "home_restaurant_list.json"
    var method: HTTPMethod = .get
}
