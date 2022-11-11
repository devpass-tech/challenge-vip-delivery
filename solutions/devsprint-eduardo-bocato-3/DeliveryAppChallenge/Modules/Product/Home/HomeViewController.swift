//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

protocol HomeViewCategoryDisplayLogic: AnyObject {
    func displayCategoryItems(_ viewModel: Home.Category.ViewModel)
//    func displaySelectedCategoryItem(_ viewModel: Home.CategorySelection.ViewModel)
    func displaySelectedCategoryItem()
}

class HomeViewController: UIViewController {

    //MARK: Dependencies
    private let interactor: HomeViewCategoryBusinessLogic
    typealias CategoryRouter = CategoryRoutingLogic & CategoryDataPassing
    var categoryRouter: CategoryRouter!

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

    func displayCategoryItems(_ viewModel: Home.Category.ViewModel) {
        DispatchQueue.main.async {
            (self.view as! HomeView).categoryListView.configureWith(viewModel)
        }
    }

    func displaySelectedCategoryItem() {
        categoryRouter.routeToSelectedCategoryItemm()
        debugPrint("category item selection done")
    }
}
