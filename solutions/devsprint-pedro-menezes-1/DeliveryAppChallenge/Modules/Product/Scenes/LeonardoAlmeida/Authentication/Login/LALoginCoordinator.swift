//
//  LALoginCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Almeida on 23/07/22.
//

import UIKit

struct LALoginCoordinator {
    static let shared = LALoginCoordinator()
    
	func navigateToHomeRoot() {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
    }
    
    func navigateToResetPassword(controller: UIViewController) {
        let storyboard = UIStoryboard(name: "LAUser", bundle: nil)
        let resetPasswordViewController = storyboard.instantiateViewController(withIdentifier: "LAResetPasswordViewController") as! LAResetPasswordViewController
        resetPasswordViewController.modalPresentationStyle = .fullScreen
        controller.present(resetPasswordViewController, animated: true)
    }
    
    func navigateToCreateAccount(controller: UIViewController) {
        let createAccountController = LACreateAccountViewController()
        createAccountController.modalPresentationStyle = .fullScreen
        controller.present(createAccountController, animated: true)
    }
    
    func alertMessage(title: String, message: String, controller: UIViewController, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            action?()
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showNoInternetConnection(controller: UIViewController) {
        let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
        let actin = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(actin)
        controller.present(alertController, animated: true)
    }
}
