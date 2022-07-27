//
//  TRResetPasswordCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Tatiana Rico on 26/07/22.
//

import Foundation
import UIKit

class TRResetPasswordCoordinator {
    var viewController: UIViewController?
    
    func contactViewController() {
        let vc = TRContactUsViewController()
        viewController?.modalPresentationStyle = .popover
        viewController?.modalTransitionStyle = .coverVertical
        viewController?.present(vc, animated: true)
    }
    
    func createAccountViewController() {
        let newVc = TRCreateAccountViewController()
        newVc.modalPresentationStyle = .fullScreen
        viewController?.present(newVc, animated: true)
    }
    
    func alertMsg(title: String, msg: String, titleAction: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: titleAction, style: .cancel)
        alertController.addAction(action)
        viewController?.present(alertController, animated: true)
    }
}
