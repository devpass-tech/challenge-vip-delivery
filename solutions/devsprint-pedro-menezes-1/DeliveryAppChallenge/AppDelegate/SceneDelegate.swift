//
//  SceneDelegate.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var gcLoginCoordinator = GCLoginCoordinator()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            gcLoginCoordinator.showViewController(vc: HomeViewController())
        } else {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = AppCoordinator.shared.getRootViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
        }
    }

}
    

