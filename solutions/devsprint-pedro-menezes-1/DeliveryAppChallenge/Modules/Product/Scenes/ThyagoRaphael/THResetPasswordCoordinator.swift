//
//  THResetPasswordCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Thyago Raphael on 21/07/22.
//

import UIKit

class THResetPasswordCoordinator {
    var controller: UIViewController?
    
    func showAlertController(title: String, message: String, messageAction: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: messageAction, style: .default)
        alertController.addAction(action)
        controller?.present(alertController, animated: true)
    }
    
    func THContactUSViewController() {
        let viewController = THContactUsViewController()
        viewController.modalPresentationStyle = .popover
        viewController.modalTransitionStyle = .coverVertical
        controller?.present(viewController, animated: true)
    }
    
    func THCreateAccontouViewController() {
        let newViewController = THCreateAccountViewController()
        newViewController.modalPresentationStyle = .fullScreen
        controller?.present(newViewController, animated: true)
    }
}
