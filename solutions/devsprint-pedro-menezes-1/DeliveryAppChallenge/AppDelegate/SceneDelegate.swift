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
        let vc = getRootController()
        self.window?.rootViewController = vc
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
    }
}

private extension SceneDelegate {
    func getRootController() -> UIViewController {
        if isUserLogged() {
            let homeFlow = UINavigationController(rootViewController: HomeViewController())
            return homeFlow
        } else {
            let loginController = AppCoordinator.shared.getRootViewController()
            return loginController
        }
    }

    func isUserLogged() -> Bool {
        let user = UserDefaultsManager.UserInfos.shared.readSesion()
        let isUserLogged = user != nil
        return isUserLogged
    }
}
