//
//  Validations.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Almeida on 23/07/22.
//

import Foundation

struct Validations {
    static let shared = Validations()
    
    func isEmail(_ email: String) -> Bool {
        let emailPattern = #"[a-zA-Z0-9._-]{2,}[@][a-zA-Z0-9]+[.][a-zA-Z0-9]+$"#
        let regex = try! NSRegularExpression(pattern: emailPattern, options: .anchorsMatchLines)
        let stringRange = NSRange(location: 0, length: email.utf16.count)
        let matches = regex.matches(in: email, range: stringRange)
        return matches.count > 0
    }
}
