//
//  GCCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Gabriel de Castro Chaves on 23/07/22.
//

import UIKit

final class GCCoordinator  {
    
    init(controller: UIViewController) {
        self.showViewController(vc: controller)
        self.showGCResetPasswordViewController(presentController: controller)
    }
        
     func showViewController(vc: UIViewController) {
        let vc = vc
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    func showGCResetPasswordViewController(presentController: UIViewController) {
        let storyboard = UIStoryboard(name: "GCUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GCResetPasswordViewController") as! GCResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        presentController.present(vc, animated: true)
    }

}
