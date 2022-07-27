//
//  LoginUserCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Tatiana Rico on 20/07/22.
//

import Foundation
import UIKit

struct LoginUserCoordinator {
    var controler: UIViewController
    
    init(controler: UIViewController) {
        self.controler = controler
    }

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
        controler.present(vc, animated: true)
    }
    
    func newAccount() {
        let controller = TRCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        controler.present(controller, animated: true)
    }
    
    func verifyLogin() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
