import UIKit

@objc protocol KeyboardAppearenceDelegate where Self: UIViewController {
    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
}

protocol KeyboardAppearenceManaging {
    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
}

class KeyboardAppearenceManager {
    weak var viewController: KeyboardAppearenceDelegate?
    private let topConstraint: NSLayoutConstraint
    private let initialConstant: CGFloat
    private let defaultSpacing: CGFloat = 100

    private var yVariation: CGFloat = 0
    private var textFieldIsMoving = false

    init(viewController: KeyboardAppearenceDelegate,
         topConstraint: NSLayoutConstraint) {
        self.viewController = viewController
        self.topConstraint = topConstraint
        self.initialConstant = topConstraint.constant
        self.startKeyboardListening()
    }
}


extension KeyboardAppearenceManager: KeyboardAppearenceManaging {
    func keyboardWillShow(_ notification: Notification) {
        upWithParentView(notification: notification)
    }

    func keyboardWillHide(_ notification: Notification) {
        downWithParentView(notification: notification)
    }
}

private extension KeyboardAppearenceManager {
    func startKeyboardListening() {
        guard let controller = viewController else { return }
        NotificationCenter.default.addObserver(controller,
                                               selector: #selector(controller.keyboardWillShow),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(controller,
                                               selector: #selector(controller.keyboardWillHide),
                                               name: UIResponder.keyboardDidHideNotification, object: nil)
    }


    func upWithParentView(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              isNeededToMoveTextfield(keyboardOriginY: keyboardSize.minY) else {
                  return
              }

        guard !textFieldIsMoving else { return }
        textFieldIsMoving = true

        let currentConstraintValue = topConstraint.constant

        UIView.animate(withDuration: 0.1, animations: {
            self.topConstraint.constant = currentConstraintValue - self.yVariation
            self.viewController?.view.layoutIfNeeded()
        }) { _ in
            self.textFieldIsMoving = false
        }
    }

    func downWithParentView(notification: Notification) {
        if topConstraint.constant != initialConstant {
            guard !textFieldIsMoving else { return }
            textFieldIsMoving = true

            UIView.animate(withDuration: 0.1, animations: {
                self.topConstraint.constant = self.initialConstant
                self.viewController?.view.layoutIfNeeded()
            }) { _ in
                self.textFieldIsMoving = false
            }
        }
    }

    func isNeededToMoveTextfield(keyboardOriginY: CGFloat) -> Bool {
        guard let textFields = viewController?.view?.allSubViewsOf(type: UITextField.self),
              let activeTextField = textFields.first(where: {$0.isFirstResponder}),
              let activeTFWindowPosition = activeTextField.superview?.convert(activeTextField.frame, to: nil) else {
            return false
              }

        let textFieldHeight = activeTextField.frame.height
        let newOriginY = keyboardOriginY - textFieldHeight - defaultSpacing
        yVariation = activeTFWindowPosition.minY - newOriginY
        let isTextFieldTooNearFromKeyboard = activeTFWindowPosition.minY > newOriginY
        return isTextFieldTooNearFromKeyboard
    }
}

extension UIView {
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}

