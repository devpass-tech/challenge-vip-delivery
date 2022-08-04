//
//  RestaurantListProtocols .swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

protocol RestaurantListInteractorProtocol {
    func fetchData()
}

protocol RestaurantListPresenterProtocol {
    func fetchedSuccessData(_ data: [RestaurantListResponse])
    func fetchedErrorData()
}

protocol RestaurantListViewControllerOutput: AnyObject {
    func showData(_ data: [RestaurantListResponse])
    func showError()
}
