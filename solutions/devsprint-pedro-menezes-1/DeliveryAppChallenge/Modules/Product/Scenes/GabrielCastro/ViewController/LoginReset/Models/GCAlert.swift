//
//  Alert.swift
//  DeliveryAppChallenge
//
//  Created by Gabriel de Castro Chaves on 28/07/22.
//

import UIKit

final class GCAlert {
    
     func showAlertMessage(title: String, message: String, targetVC: UIViewController, action: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let buttonOk = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                action?()
            })
            alert.addAction(buttonOk)
            targetVC.present(alert, animated: true, completion: nil)
        }
    
     func showNoInternetCOnnection(controller: UIViewController) {
        let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
        let actin = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(actin)
        controller.present(alertController, animated: true)
    }
    
}
