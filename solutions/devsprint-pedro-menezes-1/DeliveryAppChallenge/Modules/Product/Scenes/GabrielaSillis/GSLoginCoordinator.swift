//
//  GSCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Gabriela Sillis on 20/07/22.
//

import UIKit

protocol GSLoginCoordinating {
    func startNavigatingFlow()
    func displayErrorAlertView()
    func navigatingToResetPassword()
    func navigatingToCreateAccount()
    var controller: UIViewController? { get set }
}

struct GSLoginCoordinator: GSLoginCoordinating {
    var controller: UIViewController?
    
    func startNavigatingFlow() {
        let viewController = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func displayErrorAlertView() {
        let alertController = UIAlertController(
            title: "Ops..",
            message: "Houve um problema, tente novamente mais tarde.",
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "Ok",
            style: .default
        )
        alertController.addAction(action)
        controller?.present(alertController, animated: true)
    }
    
    func navigatingToResetPassword() {
        let storyboard = UIStoryboard(name: "GSUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GSResetPasswordViewController") as! GSResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        controller?.present(vc, animated: true)
    }
    
    func navigatingToCreateAccount() {
        let viewController = GSCreateAccountViewController()
        viewController.modalPresentationStyle = .fullScreen
        controller?.present(viewController, animated: true)
    }
}
