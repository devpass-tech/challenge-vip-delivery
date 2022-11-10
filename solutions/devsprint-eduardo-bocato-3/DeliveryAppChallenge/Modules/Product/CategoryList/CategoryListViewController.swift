//
//  CategoryListViewController.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 10/11/22.
//

import UIKit

protocol CategoryListDisplayLogic: AnyObject {
    func displayCategoryItems(_ viewModel: Home.Category.ViewModel)
    func displaySelectedCategoryItem(_ viewModel: Home.CategorySelection.ViewModel)
}

class CategoryListViewController: UIViewController {
    // MARK: Dependencies
    private let interactor: CategoryListBusinessLogic
    
    // MARK: UI Elements
    private let customView: CategoryListView
    
    // MARK: Initializers
    
    init(customView: CategoryListView,
         interactor: CategoryListBusinessLogic) {
        self.customView = customView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        view = customView
        customView.didSelectItem = { [interactor] index in
            interactor.selectCategoryItem(.init(index: index))
        }
        super.loadView()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        fetchData()
    }
    
    private func fetchData() {
        let request = Home.Category.Request()
        interactor.loadCategoryItemList(request)
    }
}

extension CategoryListViewController: CategoryListDisplayLogic {
    func displayCategoryItems(_ viewModel: Home.Category.ViewModel) {
        self.customView.configureWith(viewModel)
    }

    func displaySelectedCategoryItem(_ viewModel: Home.CategorySelection.ViewModel) {
        debugPrint("\(viewModel.title) selected")
    }
}
