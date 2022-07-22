import UIKit

protocol TextfieldReturnKeyManaging: NSObject {
    func start(textfields: [UITextField], lastKeyType: UIReturnKeyType, completionLastKey: (()->Void)?)
}

class TextfieldReturnKeyManager: NSObject{
    private var textfields: [UITextField] = []
    private var completion: (()->Void)?
}

extension TextfieldReturnKeyManager: TextfieldReturnKeyManaging {
    func start(textfields: [UITextField], lastKeyType: UIReturnKeyType, completionLastKey: (()->Void)? = nil) {
        self.completion = completionLastKey
        self.textfields = textfields
        let lastIndex = textfields.indices.last
        textfields.enumerated().forEach { index, textfield in
            textfield.delegate = self
            if index == lastIndex {
                textfield.returnKeyType = lastKeyType
            } else {
                textfield.returnKeyType = .next
            }

        }
    }

}

extension TextfieldReturnKeyManager: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var indexOfSelectedTextfield = 0
        textfields.enumerated().forEach { index, textfield_ in
            if textfield_ == textField {
                indexOfSelectedTextfield = index
            }
        }
        if indexOfSelectedTextfield == textfields.indices.last {
            textField.resignFirstResponder()
            completion?()
        } else {
            textfields[indexOfSelectedTextfield+1].becomeFirstResponder()
        }
        return true
    }
}
