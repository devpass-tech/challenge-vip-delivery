//
//  GCCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Gabriel de Castro Chaves on 23/07/22.
//

import UIKit

final class GCCoordinator: GCCoordinatorDelegate {
    
    internal func showViewController(vc: UIViewController) {
        let vc = vc
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
