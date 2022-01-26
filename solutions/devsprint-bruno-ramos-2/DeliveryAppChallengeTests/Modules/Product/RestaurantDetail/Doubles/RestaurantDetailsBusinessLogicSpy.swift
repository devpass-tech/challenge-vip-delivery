import Foundation

@testable import DeliveryAppChallenge

final class RestaurantDetailsBusinessLogicSpy: RestaurantDetailsBusinessLogic {

    private(set) var requestFetchRestaurantMenuCalled = false
    private(set) var requestFetchRestaurantMenuRequestPassed: RestaurantDetailsUseCases.FetchMenu.Request?

    func requestFetchRestaurantMenu(request: RestaurantDetailsUseCases.FetchMenu.Request) {
        requestFetchRestaurantMenuCalled = true
        requestFetchRestaurantMenuRequestPassed = request
    }
}
