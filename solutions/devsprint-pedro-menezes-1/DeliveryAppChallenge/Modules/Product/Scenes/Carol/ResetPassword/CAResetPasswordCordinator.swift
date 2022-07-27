//
//  CAResetPasswordCordinator.swift
//  DeliveryAppChallenge
//
//  Created by Carolina Quiterio on 27/07/22.
//

import UIKit

class CAResetPasswordCoordinator {
    var controller: UIViewController?
    
    func navigateToCAContactUsViewController() {
        let destinationViewController = CAContactUsViewController()
        destinationViewController.modalPresentationStyle = .popover
        destinationViewController.modalTransitionStyle = .coverVertical
        controller?.present(destinationViewController, animated: true, completion: nil)
    }
    
    func navigateToCACreateAccountViewController() {
        let destinationViewController = CACreateAccountViewController()
        destinationViewController.modalPresentationStyle = .fullScreen
        controller?.present(destinationViewController, animated: true)
    }
    
    func presentGenericErrorAlert() {
        let alertController = UIAlertController(
            title: "Ops..",
            message: "Algo de errado aconteceu. Tente novamente mais tarde.",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "OK",
            style: .default
        )
        
        alertController.addAction(action)
        controller?.present(alertController, animated: true)
    }
}
