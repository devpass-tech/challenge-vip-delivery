//
//  Validator.swift
//  DeliveryAppChallenge
//
//  Created by Gabriel de Castro Chaves on 23/07/22.
//


// to do: implementar outras logicas de login no ViewModel
final class GCLoginViewModel {
            
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
    

