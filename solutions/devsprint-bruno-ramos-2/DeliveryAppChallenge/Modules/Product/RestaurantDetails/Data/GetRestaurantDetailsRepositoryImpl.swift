import Foundation

final class GetRestaurantDetailsRepositoryImpl: GetRestaurantDetailsRepository {
    private let primaryDataSource: RestaurantDetailsDataSource
    private let secondDataSource: RestaurantDetailsDataSource

    init(primaryDataSource: RestaurantDetailsDataSource, secondDataSource: RestaurantDetailsDataSource) {
        self.primaryDataSource = primaryDataSource
        self.secondDataSource = secondDataSource
    }

    func getRestaurantDetails(by restaurantId: String, completion: @escaping (Result<RestaurantDetails, Error>) -> Void) {
        primaryDataSource.fetchRestaurantDetailsData(by: restaurantId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                switch error {
                case is EmptyCache:
                    self.secondDataSource.fetchRestaurantDetailsData(by: restaurantId, completion: completion)
                default:
                    completion(.failure(error))
                }
            }

        }
    }
}
