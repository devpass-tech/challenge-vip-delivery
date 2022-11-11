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

        let homeCategoryPresenter = HomeviewCategoryPresenter() //Presenter
        let homeCategoryWorker = HomeCategoryWorker.getCategoryWorker() // worker
        let homeCategoryInteractor =  HomeViewCategoryInteractor(presenter: homeCategoryPresenter, categoryWorker: homeCategoryWorker) // Interactor

        let homeVC = HomeViewController(interactor: homeCategoryInteractor) // HomeViewController

        let categoryRouter: CategoryRouter = .init(viewController: homeVC) // Router
        categoryRouter.dataStore = homeCategoryInteractor // DataStore setting into Router
        homeCategoryPresenter.viewController = homeVC // ViewController setting into Presenter

        homeVC.categoryRouter = categoryRouter // Router setting into HomeViewController


        self.window?.rootViewController = UINavigationController(rootViewController: homeVC)
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
    }
}

