import Foundation

protocol GetRestaurantDetailsUseCase {
    func execute(request: GetRestaurantDetailsUseCaseRequest, completion: @escaping (Result<RestaurantDetails, Error>) -> Void)
}

struct GetRestaurantDetailsUseCaseRequest {
    let restaurantId: String
}

final class GetRestaurantDetails: GetRestaurantDetailsUseCase {
    let repository: GetRestaurantDetailsRepository

    init(repository: GetRestaurantDetailsRepository) {
        self.repository = repository
    }

    func execute(request: GetRestaurantDetailsUseCaseRequest, completion: @escaping (Result<RestaurantDetails, Error>) -> Void) {
        repository.getRestaurantDetails(by: request.restaurantId, completion: completion)
    }
}
