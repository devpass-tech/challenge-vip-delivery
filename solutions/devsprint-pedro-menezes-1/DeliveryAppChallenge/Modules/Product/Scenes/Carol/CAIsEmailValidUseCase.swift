//
//  IsEmailValidUseCase.swift
//  DeliveryAppChallenge
//
//  Created by Carolina Quiterio on 27/07/22.
//

import Foundation

class CAIsEmailValidUseCase {
    
    func simpleValidation(_ email: String?) -> Bool {
        let emailContainsAnyInvalidCondition = email!.isEmpty ||
            !email!.contains(".") ||
            !email!.contains("@") ||
            email!.count <= 5
        
        return !emailContainsAnyInvalidCondition
    }
}
