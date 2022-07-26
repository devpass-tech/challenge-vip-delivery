//
//  SceneDelegate.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = setRootViewController()
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    
    func setRootViewController() -> UIViewController {
        if isUserLogged() {
            let homeViewController = UINavigationController(rootViewController: HomeViewController())
            return homeViewController
        } else {
            let loginViewController = AppCoordinator.shared.getRootViewController()
            return loginViewController
        }
    }
    func isUserLogged() -> Bool {
        let userSession = UserDefaultsManager.UserInfos.shared.readSesion()
        let isUserLogged = userSession != nil
        return isUserLogged
    }
}
