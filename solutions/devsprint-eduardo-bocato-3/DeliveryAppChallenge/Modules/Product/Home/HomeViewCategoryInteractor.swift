//
//  HomeViewInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Aby Mathew on 01/11/22.
//

import Foundation

protocol HomeViewCategoryBusinessLogic {
    func loadCategoryItemList(_ request: Home.Category.Request)
    func selectCategoryItem(_ request: Home.CategorySelection.Request)
}


protocol CategoryDataStore {
    var selectedCategory: CategoryItem? { get set }
}


final class HomeViewCategoryInteractor: HomeViewCategoryBusinessLogic, CategoryDataStore {

    //MARK: Dependencies
    private let presenter: HomeViewCategoryPresentationLogic
    private var categoryWorker: CategoryWorkerProtocol

    // MARK: - Private Properties
    private var categoryItems = [CategoryItem]()
    var selectedCategory: CategoryItem?

    // MARK: - Initialization
    init(
        presenter: HomeViewCategoryPresentationLogic,
        categoryWorker: CategoryWorkerProtocol
    ) {

        self.presenter = presenter
        self.categoryWorker = categoryWorker
    }

    func loadCategoryItemList(_ request: Home.Category.Request) {

        // worker perform load items (NetworkManger need to perform an API call for "category" items fetching)
        categoryWorker.fetchCategoryItems { [unowned self, presenter] result in

            switch result {
                case .success(let categoryItems):
                    self.categoryItems = categoryItems
                    let request = Home.Category.Response.init(items: categoryItems)
                    presenter.presentCategoryItemsList(request) // Interactor -> Presenter

                case .failure(let error):
                    print(error)
            }
        }


    }

    func selectCategoryItem(_ request: Home.CategorySelection.Request) {
        let selectedItem = categoryItems[request.index]
        let response: Home.CategorySelection.Response = selectedItem
        self.selectedCategory = selectedItem
        presenter.presentCategoryItemSelection(response)
    }


}
