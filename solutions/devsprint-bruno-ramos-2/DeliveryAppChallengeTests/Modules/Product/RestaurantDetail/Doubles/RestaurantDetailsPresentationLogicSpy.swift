import Foundation

@testable import DeliveryAppChallenge

final class RestaurantDetailsPresentationLogicSpy: RestaurantDetailsPresentationLogic {

    private(set) var presentRestaurantMenuCalled = false
    private(set) var presentRestaurantMenuResponsePassed: RestaurantDetailsUseCases.FetchMenu.Response?
    func presentRestaurantMenu(response: RestaurantDetailsUseCases.FetchMenu.Response) {
        presentRestaurantMenuCalled = true
        presentRestaurantMenuResponsePassed = response
    }
}
