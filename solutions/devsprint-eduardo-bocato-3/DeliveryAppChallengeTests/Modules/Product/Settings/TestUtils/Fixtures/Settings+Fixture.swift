
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
