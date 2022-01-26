import Foundation

protocol RestaurantDetailsWorking {
    func fetchData(completion: @escaping (Result<String, Error>) -> Void)
}

final class RestaurantDetailsWorker: RestaurantDetailsWorking {
    private let network: NetworkManagerProtocol

    init(network: NetworkManagerProtocol) {
        self.network = network
    }

    func fetchData(completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success(""))
    }
}

struct RestaurantFetchDataError: Error {}
