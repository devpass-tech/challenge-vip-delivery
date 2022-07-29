//
//  PTCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 28/07/22.
//

import Foundation
import UIKit

final class PTCoordinator {
    
    var controller: UIViewController?
    
    func showViewController(vc: UIViewController) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
    
    func showPTResetPasswordViewController(presentController: UIViewController) {
        let storyboard = UIStoryboard(name: "PTUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PTResetPasswordViewController") as! GCResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        controller?.present(vc, animated: true)
    }
        
    func showAlert() {
        let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
        let actin = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(actin)
        controller?.present(alertController, animated: true)
    }
    
    func navigateToHome(){
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    func navigateToCreateAccount(){
        let createAccountViewController = PTCreateAccountViewController()
        createAccountViewController.modalPresentationStyle = .fullScreen
        controller?.present(createAccountViewController, animated: true)
    }
}
