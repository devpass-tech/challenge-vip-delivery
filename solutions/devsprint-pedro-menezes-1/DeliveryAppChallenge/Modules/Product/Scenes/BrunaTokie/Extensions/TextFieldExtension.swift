import Foundation
import UIKit

extension UITextField {
    func isPasswordTextFieldValid(withText emailTextField: String?) -> Bool {
        let emailContainsDot = emailTextField?.contains(".") ?? false
        let emailContainsAt = emailTextField?.contains("@") ?? false
        let emailHasValidSize = emailTextField?.count ?? 0 > 5
        let emailIsValid = emailContainsDot && emailContainsAt && emailHasValidSize
        return emailIsValid
    }
}
