import Foundation

final class RestaurantDetailsApiDataSource: RestaurantDetailsDataSource {
    private let network: NetworkManagerProtocol

    init(network: NetworkManagerProtocol) {
        self.network = network
    }

    func fetchRestaurantDetailsData(by restaurantId: String, completion: @escaping (Result<RestaurantDetails, Error>) -> Void) {
        let request = RestaurantDetailsRequest(restaurantId: restaurantId)
        network.request(request) { (result: Result<RestaurantDetailsResponse, Error>) in
            switch result {
            case .success(let restaurantDetailsResponse):
                completion(.success(.init(from: restaurantDetailsResponse)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
