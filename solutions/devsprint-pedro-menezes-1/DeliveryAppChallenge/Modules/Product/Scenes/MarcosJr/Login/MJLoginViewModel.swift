//
//  MJLoginViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Marcos Jr on 27/07/22.
//

import UIKit
import Foundation

final class MJLoginViewModel {
    func isEmailValid(_ email: String) -> Bool {
        let emailContainsDot = email.contains(".")
        let emailContainsAt = email.contains("@")
        let emailSizeGreaterThanFive = email.count > 5
        
        if emailContainsDot && emailContainsAt && emailSizeGreaterThanFive {
            if let atIndex = email.firstIndex(of: "@") {
                let substring = email[atIndex...]
                return substring.contains(".") ? true : false
            }
        }
        return false
    }
}
