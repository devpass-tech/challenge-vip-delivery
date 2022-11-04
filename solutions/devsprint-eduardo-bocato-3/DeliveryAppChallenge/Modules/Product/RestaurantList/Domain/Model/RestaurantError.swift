//
//  RestaurantError.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 04/11/22.
//

import Foundation

enum GetRestaurantError: Error {
    case defaultError(message: String?)
    case noData
    case invalidData
}
