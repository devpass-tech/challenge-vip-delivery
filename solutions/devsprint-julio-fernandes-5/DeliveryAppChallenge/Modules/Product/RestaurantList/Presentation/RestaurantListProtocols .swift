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
    func fetchedSuccessData()
    func fetchedErrorData()
}

protocol RestaurantListViewControllerOutput: AnyObject {
    func showData()
    func showError()
}
