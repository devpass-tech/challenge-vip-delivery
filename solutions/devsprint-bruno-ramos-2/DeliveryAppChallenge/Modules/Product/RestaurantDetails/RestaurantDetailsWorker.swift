import Foundation

protocol RestaurantDetailsWorking {
    func fetchData(completion: @escaping (Result<RestaurantDetailsResponse, APIError>) -> Void)
}

final class RestaurantDetailsWorker: RestaurantDetailsWorking {
    private let network: NetworkManagerProtocol

    init(network: NetworkManagerProtocol) {
        self.network = network
    }

    func fetchData(completion: @escaping (Result<RestaurantDetailsResponse, APIError>) -> Void) {
        network.request(RestaurantDetailsRequest()) { (result: Result<RestaurantDetailsResponse, Error>) in
            switch result {
            case .success(let restaurantDetails):
                completion(.success(restaurantDetails))
            case .failure(_):
                completion(.failure(.networkError))
            }
        }
    }
}
