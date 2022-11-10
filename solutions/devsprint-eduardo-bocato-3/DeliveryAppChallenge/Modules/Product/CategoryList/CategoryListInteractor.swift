//
//  CategoryListInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 10/11/22.
//

import Foundation

protocol CategoryListBusinessLogic {
    func loadCategoryItemList(_ request: Home.Category.Request)
    func selectCategoryItem(_ request: Home.CategorySelection.Request)
}


final class CategoryListInteractor: CategoryListBusinessLogic {
    //MARK: Dependencies
    private let presenter: CategoryListPresentationLogic

    private var categoryItems = [CategoryItem]()

    init(presenter: CategoryListPresentationLogic) {
        self.presenter = presenter
    }

    func loadCategoryItemList(_ request: Home.Category.Request) {

        // worker perform load items (NetworkManger need to perform an API call for "category" items fetching)

        // pass response into presenter
        categoryItems = [CategoryItem(title: "Pizza1", imageName: "pizza"),
                             CategoryItem(title: "Pizza2", imageName: "pizza"),
                             CategoryItem(title: "Pizza3", imageName: "pizza"),
                             CategoryItem(title: "Pizza4", imageName: "pizza"),
                             CategoryItem(title: "Pizza5", imageName: "pizza"),
                             CategoryItem(title: "Pizza6", imageName: "pizza"),
                             CategoryItem(title: "Pizza7", imageName: "pizza"),
                             CategoryItem(title: "Pizza8", imageName: "pizza"),
                             CategoryItem(title: "Pizza9", imageName: "pizza")]

        let request = Home.Category.Response.init(items: categoryItems)
        self.presenter.presentCategoryItemsList(request)
    }

    func selectCategoryItem(_ request: Home.CategorySelection.Request) {
        let response: Home.CategorySelection.Response = categoryItems[request.index]
        presenter.presentCategoryItemSelection(response)
    }
}
