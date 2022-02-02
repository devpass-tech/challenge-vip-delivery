import Foundation

protocol RestaurantDetailsDataSource {
    func fetchRestaurantDetailsData(by restaurantId: String, completion: @escaping (Result<RestaurantDetails, Error>) -> Void)
}
