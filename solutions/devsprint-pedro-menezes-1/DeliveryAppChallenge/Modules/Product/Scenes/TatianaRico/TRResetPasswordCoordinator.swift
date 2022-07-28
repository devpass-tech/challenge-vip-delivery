//
//  TRResetPasswordCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Tatiana Rico on 26/07/22.
//

import Foundation
import UIKit

final class TRResetPasswordCoordinator {
    public var viewController: UIViewController?
    
    public func contactViewController() {
        let vc = TRContactUsViewController()
        viewController?.modalPresentationStyle = .popover
        viewController?.modalTransitionStyle = .coverVertical
        viewController?.present(vc, animated: true)
    }
    
    public func createAccountViewController() {
        let newVc = TRCreateAccountViewController()
        newVc.modalPresentationStyle = .fullScreen
        viewController?.present(newVc, animated: true)
    }
    
    public func alertMsg(title: String, msg: String, titleAction: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: titleAction, style: .cancel)
        alertController.addAction(action)
        viewController?.present(alertController, animated: true)
    }
    
    public func alertConection(titleAlert: String, messageAlert: String, messageActionAlert: String) {
        let alertController = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: messageActionAlert, style: .default)
        alertController.addAction(actionAlert)
        viewController?.present(alertController, animated: true)
    }
}
