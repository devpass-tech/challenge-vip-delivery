//
//  LoginUserCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Tatiana Rico on 20/07/22.
//

import Foundation
import UIKit


class LoginUserCoordinator: UIViewController {

     func changeScreenHome() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    func userResetPassword() {
        let storyboard = UIStoryboard(name: "TRUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TRResetPasswordViewController") as! TRResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func newAccount() {
        let controller = TRCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
