//
//  RLLoginCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Lemos on 28/07/22.
//

import UIKit

class RLLoginCoordinator {

    func showHomeViewController() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

    func showNoConnectionAlert(on viewController: UIViewController) {
        let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
        let actin = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(actin)
        viewController.present(alertController, animated: true)
        return
    }

    func showRequestError(on viewController: UIViewController) {
        Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.",
                             targetVC: viewController)
    }

    func showResetPasswordViewController(on viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "RLUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RLResetPasswordViewController") as! RLResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true)
    }

    func showCreateAccountViewController(on viewController: UIViewController) {
        let controller = RLCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        viewController.present(controller, animated: true)
    }
}

