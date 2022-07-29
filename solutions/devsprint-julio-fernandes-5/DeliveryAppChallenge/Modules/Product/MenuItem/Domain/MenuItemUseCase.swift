//
//  MenuItemUseCase.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 29/07/22.
//

import Foundation

protocol MenuItemUseCaseProtocol {
    func execute(completion: @escaping (Result<[MenuItemResponse], Error>) -> Void)
}

final class MenuItemUseCase {
    private let repository: MenuItemRepositoryProtocol
    
    init(repository: MenuItemRepositoryProtocol){
        self.repository = repository
    }
}

extension MenuItemUseCase: MenuItemUseCaseProtocol {
    func execute(completion: @escaping (Result<[MenuItemResponse], Error>) -> Void) {
        repository.fetchData { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
