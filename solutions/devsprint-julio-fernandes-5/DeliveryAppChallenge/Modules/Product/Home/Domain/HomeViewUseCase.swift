//
//  HomeViewUseCase.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

protocol HomeViewUseCaseProtocol {
    func execute(completion: @escaping (Result<[RestaurantDetailResponse], Error>) -> Void)
}

final class HomeViewUseCase {
    private let repository: HomeViewRepositoryProtocol

    init(repository: HomeViewRepositoryProtocol) {
        self.repository = repository
    }
}

extension HomeViewUseCase: HomeViewUseCaseProtocol {
    
    /// Executamos a ação necessária para obter os dados necessários que serão enviados para o nosso VIP
    /// - Parameter completion: completion (Lista de restaurantes, error)
    func execute(completion: @escaping (Result<[RestaurantDetailResponse], Error>) -> Void) {
        repository.fetchData { result in
            switch result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(.failure(error))
            }
        }
    }
}
