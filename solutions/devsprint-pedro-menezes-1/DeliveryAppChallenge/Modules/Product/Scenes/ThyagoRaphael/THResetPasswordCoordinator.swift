//
//  THResetPasswordCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Thyago Raphael on 21/07/22.
//

import UIKit

class THResetPasswordCoordinator {
    let controller = UIViewController()
    
    func showAlertController(title: String, message: String, messageAction: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: messageAction, style: .default)
        alertController.addAction(action)
        controller.present(alertController, animated: true)
    }
    
    func THContactUSViewController() {
        let vc = THContactUsViewController()
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .coverVertical
        controller.present(vc, animated: true, completion: nil)
    }
    
    func THCreateAccontouViewController() {
        let newVc = THCreateAccountViewController()
        newVc.modalPresentationStyle = .fullScreen
        controller.present(newVc, animated: true)
    }
}
