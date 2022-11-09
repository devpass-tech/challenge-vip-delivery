//
//  Settings+Fixture.swift
//  DeliveryAppChallengeTests
//
//  Created by Douglas Garcia on 09/11/22.
//

import Foundation
@testable import DeliveryAppChallenge

extension Settings {
    static func fixture(name: String = "name",
                        email: String = "email",
                        address: String = "address",
                        paymentMethod: String = "paymentMethod") -> Self {
        .init(name: name,
              email: email,
              address: address,
              paymentMethod: paymentMethod)
    }
}
