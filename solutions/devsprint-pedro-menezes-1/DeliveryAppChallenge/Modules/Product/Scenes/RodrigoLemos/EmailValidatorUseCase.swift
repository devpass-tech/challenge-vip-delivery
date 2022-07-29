//
//  EmailValidatorUseCase.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Lemos on 28/07/22.
//

import Foundation

struct EmailValidatorUseCase {

    func isEmailValid(for text: String) -> Bool {
        let emailTextNotContainsDot = !text.contains(".")
        let emailTextNotContainsAt = !text.contains("@")
        let emailTextCountLessThanOrEqualTo5 = text.count <= 5

        if emailTextNotContainsDot || emailTextNotContainsAt || emailTextCountLessThanOrEqualTo5 {
            return false
        }

        if let atIndex = text.firstIndex(of: "@") {
            let substring = text[atIndex...]
            if substring.contains(".") {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}

