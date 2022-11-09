////
////  HomeViewRestaurantListInteractor.swift
////  DeliveryAppChallenge
////
////  Created by Matheus Lenke on 08/11/22.
////
//
//import Foundation
//
//protocol HomeViewRestaurantListBusinessLogic {
//    func loadRestaurantList(_ request: Home.RestaurantList.Request)
//}
//
//
//final class HomeViewRestaurantListInteractor: HomeViewRestaurantListBusinessLogic {
//    
//    //MARK: Dependencies
//    private let presenter: HomeViewRestaurantListPresentationLogic
//
//    private var categoryItems = [CategoryItem]()
//
//    init(presenter: HomeViewCategoryPresentationLogic) {
//        self.presenter = presenter
//    }
//    
//    func loadRestaurantList(_ request: Home.RestaurantList.Request) {
//        <#code#>
//    }
//
//    func selectCategoryItem(_ request: Home.CategorySelection.Request) {
//        let response: Home.CategorySelection.Response = categoryItems[request.index]
//        presenter.presentCategoryItemSelection(response)
//    }
//
//
//}
