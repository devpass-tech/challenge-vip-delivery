//
//  HomeViewCategoryPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Aby Mathew on 02/11/22.
//

import Foundation

protocol HomeViewCategoryPresentationLogic {
    func presentCategoryItemsList(_ response: Home.Category.Response)
    func presentCategoryItemSelection(_ response: Home.CategorySelection.Response)
}


final class HomeviewCategoryPresenter: HomeViewCategoryPresentationLogic {

    //MARK: Dependencies
    weak var viewController: HomeViewCategoryDisplayLogic?
    
    func presentCategoryItemsList(_ response: Home.Category.Response) {

        let categoryViewModelItems = response.items.map {
            CategoryViewModel(title: $0.title, imageName: $0.imageName)
        }
        let viewModel = Home.Category.ViewModel(items: categoryViewModelItems)

        // passing viewmodel to viewcontroller
        viewController?.displayCategoryItems(viewModel)

    }

    func presentCategoryItemSelection(_ response: Home.CategorySelection.Response) {

//        let viewModel = Home.CategorySelection.ViewModel(title: response.title,
//                                                         imageName: response.imageName)
//        viewController?.displaySelectedCategoryItem(viewModel)

        viewController?.displaySelectedCategoryItem()
    }
}
