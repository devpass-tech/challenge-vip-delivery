//
//  StepToLogin.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Almeida on 25/07/22.
//

import Foundation


enum StepToLogin {
    case invalidData
    case noInternet
    case loginRequest(email: String, password: String)
}
