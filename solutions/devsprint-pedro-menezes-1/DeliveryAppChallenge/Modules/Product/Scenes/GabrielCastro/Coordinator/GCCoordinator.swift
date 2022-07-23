//
//  GCCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Gabriel de Castro Chaves on 23/07/22.
//

import UIKit

protocol GCCoordinatorDelegate: AnyObject {
    func setErrorLogin(_ message: String)
}

final class GCCoordinator: GCLoginViewControllerDelegate  {
    
    weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    weak var gCCoordinatorDelegate: GCCoordinatorDelegate?
    
    internal func showViewController(vc: UIViewController) {
        let vc = vc
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    internal  func showRequestError(_ targetVC: UIViewController) {
        gCCoordinatorDelegate?.setErrorLogin("E-mail ou senha incorretos")
         Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: targetVC)
     }
    
    internal func showGCResetPasswordViewController() {
        let storyboard = UIStoryboard(name: "GCUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GCResetPasswordViewController") as! GCResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        controller?.present(vc, animated: true)
    }

}
