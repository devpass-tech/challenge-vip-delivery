//
//  HomeViewRepository.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

protocol HomeViewRepositoryProtocol {
    func fetchData(completion: @escaping (Result<[RestaurantDetailResponse], NetworkError>) -> Void)
}


/// O Padrão de Repositório ganhou bastante popularidade desde que foi introduzido pela primeira vez como parte do Design Orientado por Domínio em 2004. Essencialmente, ele fornece uma abstração de dados, para que seu aplicativo possa trabalhar com uma abstração simples que tenha uma interface que se aproxime da de uma coleção.
final class HomeViewRepository {
    
    let network: NetworkManagerProtocol
    
    private let group: DispatchGroup = DispatchGroup()
    private var homeDataSource: [RestaurantDetailResponse]?
    private var settingsDataSource: [RestaurantDetailResponse]?
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
    
}

extension HomeViewRepository: HomeViewRepositoryProtocol {
    
    /// Executamos nossa chamada de network para obter os dados de API
    /// - Parameter completion: completion (Lista de restaurantes, Error)
    func fetchData(completion: @escaping (Result<[RestaurantDetailResponse], NetworkError>) -> Void) {
        fetchHomeDataSource(completion: completion)
        fetchSettingsDataSource(completion: completion)
        
        group.notify(queue: .main) { [weak self] in
            guard let homeDataSource = self?.homeDataSource,
                  let settingsDataSource = self?.settingsDataSource else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(homeDataSource))
        }
    }
    
    func fetchHomeDataSource(completion: @escaping (Result<[RestaurantDetailResponse], NetworkError>) -> Void) {
        group.enter()
        network.request(HomeViewEndpoint()) { [weak self] (response: Result<[RestaurantDetailResponse], Error>) in
            switch response {
            case let .success(dataDTO):
                self?.homeDataSource = dataDTO
            default: self?.group.leave()
            }
        }
    }
    
    func fetchSettingsDataSource(completion: @escaping (Result<[RestaurantDetailResponse], NetworkError>) -> Void) {
        group.enter()
        network.request(HomeViewEndpoint()) { [weak self] (response: Result<[RestaurantDetailResponse], Error>) in
            switch response {
            case let .success(dataDTO):
                self?.settingsDataSource = dataDTO
            default: self?.group.leave()
            }
        }
    }
}
