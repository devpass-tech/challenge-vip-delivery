//
//  TRLoginViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Tatiana Rico on 27/07/22.
//

import Foundation

final class TRLoginViewModel {
    func validateEmail(textField: String) -> Bool {
             guard let atIndex = textField.firstIndex(of: "@") else {
                 return false
             }
             let emailHasDot = textField.contains(".")
             let emailHasAt = textField.contains("@")
             let emailIsHigherOrEqualToFive = textField.count >= 5
             let substring = textField[atIndex...]
             let substringHasDot = substring.contains(".")

             if  emailHasDot &&
                 emailHasAt &&
                 emailIsHigherOrEqualToFive &&
                 substringHasDot {
                 return true
             } else {
                 return false
             }
         }
}
