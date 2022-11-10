//
//  CategoryListPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 10/11/22.
//

import Foundation

protocol CategoryListPresentationLogic {
    func presentCategoryItemsList(_ response: Home.Category.Response)
    func presentCategoryItemSelection(_ response: Home.CategorySelection.Response)
}


final class CategoryListPresenter: CategoryListPresentationLogic {

    //MARK: Dependencies
    weak var viewController: CategoryListDisplayLogic?
    
    func presentCategoryItemsList(_ response: Home.Category.Response) {

        let categoryViewModelItems = response.items.map {
            CategoryViewModel(title: $0.title, imageName: $0.imageName)
        }
        let viewModel = Home.Category.ViewModel(items: categoryViewModelItems)

        // passing viewmodel to viewcontroller
        viewController?.displayCategoryItems(viewModel)

    }

    func presentCategoryItemSelection(_ response: Home.CategorySelection.Response) {

        let viewModel = Home.CategorySelection.ViewModel(title: response.title,
                                                         imageName: response.imageName)
        viewController?.displaySelectedCategoryItem(viewModel)
    }
}
