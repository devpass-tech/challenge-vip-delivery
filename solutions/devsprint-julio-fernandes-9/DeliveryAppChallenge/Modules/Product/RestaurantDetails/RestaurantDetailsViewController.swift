//
//  RestaurantDetailsViewController.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 20/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol RestaurantDetailsDisplayLogic where Self: UIViewController {
    func displayViewModel(_ viewModel: RestaurantDetailsModel.ViewModel)
}

final class RestaurantDetailsViewController: UIViewController {
    
    private let mainView: RestaurantDetailsViewProtocol
    private let interactor: RestaurantDetailsBusinessLogic
    private let router: RestaurantDetailsRouting
    
    init(mainView: RestaurantDetailsViewProtocol = RestaurantDetailsView(),
         interactor: RestaurantDetailsBusinessLogic,
         router: RestaurantDetailsRouting) {
            
        self.mainView = mainView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.doRequest(.fetchRestaurantDetail)
        
    }
    
    override func loadView() {
        mainView.delegate = self
        view = mainView
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, You should't initialize the ViewController through Storyboards")
    }
}

// MARK: - RestaurantDetailsDisplayLogic
extension RestaurantDetailsViewController: RestaurantDetailsDisplayLogic {
    
    func displayViewModel(_ viewModel: RestaurantDetailsModel.ViewModel) {
        DispatchQueue.main.async {
            switch viewModel {
            case .viewModel(let restaurant):
                self.mainView.updateView(restaurant: restaurant)
            case .viewModelWithError(let messageError):
                print(messageError)
            }
        }
    }
}

// MARK: - RestaurantDetailsViewDelegate
extension RestaurantDetailsViewController: RestaurantDetailsViewDelegate {
    func didTapMenu(menu: Menu) {
        router.routeTo(.goToMenuItem)
    }
}
