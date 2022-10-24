//
//  RestaurantDetailsUseCase.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 04/08/22.
//

import Foundation

protocol RestaurantDetailsUseCaseProtocol {
    func execute(completion: @escaping (Result<RestaurantDetailViewModel, NetworkError>) -> Void)
}

final class RestaurantDetailsUseCase {
    private let repository: RestaurantDetailRepositoryProtocol
    
    init(repository: RestaurantDetailRepositoryProtocol){
        self.repository = repository
    }
    
    private func convertoViewModel(_ data: RestaurantDetailResponse) -> RestaurantDetailViewModel {
        let infoView = RestaurantListResponse(name: data.name, category: data.category, deliveryTime: data.deliveryTime)
        let viewModel = RestaurantDetailViewModel(infoView: infoView, reviews: data.reviews, menu: data.menu)
        return viewModel
    }
}

extension RestaurantDetailsUseCase: RestaurantDetailsUseCaseProtocol {
    func execute(completion: @escaping (Result<RestaurantDetailViewModel, NetworkError>) -> Void) {
        repository.fetchData { [weak self] result in
            guard let self = self else {
                completion(.failure(.networkError))
                return
            }
            switch result {
            case .success(let data): completion(.success(self.convertoViewModel(data)))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
