import Foundation

final class RestaurantDetailsCacheDataSource: RestaurantDetailsDataSource {
    private var cache: [String: RestaurantDetails] = [:]

    func fetchRestaurantDetailsData(by restaurantId: String, completion: @escaping (Result<RestaurantDetails, Error>) -> Void) {
        guard let cacheValue = cache[restaurantId] else {
            return completion(.failure(EmptyCache()))
        }

        completion(.success(cacheValue))
    }
}


struct EmptyCache: Error {}
