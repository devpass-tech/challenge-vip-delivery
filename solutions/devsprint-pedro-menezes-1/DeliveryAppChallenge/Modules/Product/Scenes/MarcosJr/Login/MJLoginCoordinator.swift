//
//  MJLoginCoordinator.swift
//  DeliveryAppChallenge
//
//  Created by Marcos Jr on 27/07/22.
//

import UIKit
import Foundation

final class MJLoginCoordinator {
    weak var viewController: MJLoginViewController?
    
    init(viewController: MJLoginViewController) {
        self.viewController = viewController
    }
    
    func updateRootViewController(navigationController: UINavigationController) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
