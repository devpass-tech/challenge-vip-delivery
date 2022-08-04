//
//  HomeViewRepository.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import Foundation

protocol HomeViewRepositoryProtocol {
    func fetchData(completion: @escaping (Result<HomeViewModel, NetworkError>) -> Void)
}


/// O Padrão de Repositório ganhou bastante popularidade desde que foi introduzido pela primeira vez como parte do Design Orientado por Domínio em 2004. Essencialmente, ele fornece uma abstração de dados, para que seu aplicativo possa trabalhar com uma abstração simples que tenha uma interface que se aproxime da de uma coleção.
final class HomeViewRepository {
    
    let network: NetworkManagerProtocol
    let settingsWorker: SettingsViewRepositoryProtocol
    
    private let group: DispatchGroup = DispatchGroup()
    private var homeDataSource: [RestaurantListResponse]?
    private var settingsDataSource: SettingsViewResponse?
    
    init(network: NetworkManagerProtocol, settingsWorker: SettingsViewRepositoryProtocol) {
        self.network = network
        self.settingsWorker = settingsWorker
    }
    
    private func fetchHomeDataSource() {
        group.enter()
        network.request(HomeViewEndpoint()) { [weak self] (response: Result<[RestaurantListResponse], Error>) in
            switch response {
            case let .success(dataDTO):
                self?.homeDataSource = dataDTO
                fallthrough
            default:
                self?.group.leave()
            }
            
        }
    }
    
    private func fetchSettingsDataSource() {
        group.enter()
        settingsWorker.fetchData { [weak self] (response: Result<SettingsViewResponse, NetworkError>) in
            switch response {
            case let .success(dataDTO):
                self?.settingsDataSource = dataDTO
                fallthrough
            default:
                self?.group.leave()
            }
        }
    }
    
}

extension HomeViewRepository: HomeViewRepositoryProtocol {
    
    /// Executamos nossa chamada de network para obter os dados de API
    /// - Parameter completion: completion (Lista de restaurantes, Error)
    func fetchData(completion: @escaping (Result<HomeViewModel, NetworkError>) -> Void) {
        fetchHomeDataSource()
        fetchSettingsDataSource()
        group.notify(queue: .main) { [weak self] in
            guard let homeDataSource = self?.homeDataSource,
                  let settingsDataSource = self?.settingsDataSource else {
                completion(.failure(.noData))
                return
            }
            
            let viewModel = HomeViewModel(list: homeDataSource, address: settingsDataSource)
            completion(.success(viewModel))
        }
    }
    
    
}
