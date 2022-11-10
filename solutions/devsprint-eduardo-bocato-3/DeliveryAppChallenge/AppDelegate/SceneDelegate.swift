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

        let addressSearchAssembler: AddressSearchAssembler = .init()
        let categoryListAssembler: CategoryListAssembler = .init()
        let restaurantListAssembler: RestaurantListAssembler = .init()
        
        let rootVC: HomeViewController = .init(addressSearchViewAssembler: addressSearchAssembler,
                                        restaurantListViewAssembler: restaurantListAssembler,
                                        categoryListAssembler: categoryListAssembler)

        self.window?.rootViewController = UINavigationController(rootViewController: rootVC)
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
    }
}
