//
//  PTCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 28/07/22.
//

import Foundation
import UIKit

final class PTCoordinator {
    
    private let controller = PTLoginViewController
    
    func showViewController(vc: UIViewController) {
        let vc = vc
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
        presentController.present(vc, animated: true)
    }
    
    func showAlert(){
        
    }
}
