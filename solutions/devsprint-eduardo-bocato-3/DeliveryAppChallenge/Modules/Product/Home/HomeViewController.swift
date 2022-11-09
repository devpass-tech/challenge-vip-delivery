//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

protocol HomeViewCategoryDisplayLogic: AnyObject {
    func displayCategoryItems(_ viewModel: Home.Category.ViewModel)
    func displaySelectedCategoryItem(_ viewModel: Home.CategorySelection.ViewModel)
    func displayRestaurantList(_ viewModel: RestaurantList.FetchRestaurants.ViewModel)
}

class HomeViewController: UIViewController {

    //MARK: Dependencies
    private let interactor: HomeViewCategoryBusinessLogic

    init(interactor: HomeViewCategoryBusinessLogic) {
        
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Delivery App"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        interactor.loadCategoryItemList(.init())

    }
    
    override func loadView() {
        let customView = HomeView()
        customView.categoryListView.didSelectItem = { [interactor] index in
            interactor.selectCategoryItem(.init(index: index))
        }
        self.view = customView
    }
}

extension HomeViewController: HomeViewCategoryDisplayLogic {
    
    func displayRestaurantList(_ viewModel: RestaurantList.FetchRestaurants.ViewModel) {
        
    }
    
    func displayCategoryItems(_ viewModel: Home.Category.ViewModel) {
        (self.view as! HomeView).categoryListView.configureWith(viewModel)
    }

    func displaySelectedCategoryItem(_ viewModel: Home.CategorySelection.ViewModel) {
        debugPrint("\(viewModel.title) selected")
    }
}
