//
//  TRLoginUserCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Tatiana Rico on 27/07/22.
//

import Foundation
import UIKit

struct TRLoginUserCoordinator {
    var controler: UIViewController?
    
    public func changeScreenHome() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    public func userResetPassword() {
        let storyboard = UIStoryboard(name: "TRUser", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TRResetPasswordViewController") as? TRResetPasswordViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        controler?.present(vc, animated: true)
    }
    
    public func newAccount() {
        let controller = TRCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        controler?.present(controller, animated: true)
    }
    
    public func goToHomeViewController() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    public func alertConection(titleAlert: String, messageAlert: String, messageActionAlert: String) {
        let alertController = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: messageActionAlert, style: .default)
        alertController.addAction(actionAlert)
        controler?.present(alertController, animated: true)
    }
}
