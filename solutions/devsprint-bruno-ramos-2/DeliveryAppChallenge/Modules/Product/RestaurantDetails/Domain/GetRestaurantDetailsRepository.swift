import Foundation

protocol GetRestaurantDetailsRepository {
    func getRestaurantDetails(by restaurantId: String, completion: @escaping (Result<RestaurantDetails, Error>) -> Void)
}
