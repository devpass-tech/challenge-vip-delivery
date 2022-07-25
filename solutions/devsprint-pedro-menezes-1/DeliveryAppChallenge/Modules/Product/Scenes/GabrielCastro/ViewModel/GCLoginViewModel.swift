//
//  Validator.swift
//  DeliveryAppChallenge
//
//  Created by Gabriel de Castro Chaves on 23/07/22.
//


// to do: implementar outras logicas de login no ViewModel
class GCLoginViewModel {
    
    var isValidEmail: ((Bool) -> Void)?
    
    func validateEmail(textField: String) {
        guard let atIndex = textField.firstIndex(of: "@") else {
            isValidEmail?(false)
            return
        }
        let substring = textField[atIndex...]
        if !textField.contains(".") ||
            !textField.contains("@") ||
            textField.count <= 5 ||
            !substring.contains(".") {
            isValidEmail?(false)
        } else {
            isValidEmail?(true)
        }
    }
    
}
