//
//  CategoryService.swift
//  DeliveryAppChallenge
//
//  Created by Aby Mathew on 08/11/22.
//

import Foundation


// Preparing to use API Requests
enum APIRequest: NetworkRequest {
    case menuItemDetails

    var pathURL: String {
        switch self {
            case .menuItemDetails:
                return "menu_item_details.json"
        }
    }
    var method: HTTPMethod {
        switch self {
            case .menuItemDetails:
                return .get
        }
    }
}

extension NetworkManagerProtocol {
    func apiRequest<T: Decodable>(_ request: APIRequest, completion: @escaping NetworkResult<T>) {
        self.request(request, completion: completion)
    }
}


protocol APIServiceProtocol {
    func getMenuItems(_ completion: @escaping (Result<[MenuItemEntity], NetworkError>) -> Void)
}

final class APIService: APIServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getMenuItems(_ completion: @escaping (Result<[MenuItemEntity], NetworkError>) -> Void) {
        networkManager.apiRequest(
            .menuItemDetails,
            completion: { (result: Result<[MenuItemEntity], Error>) in
                switch result {
                    case let .success(items):
                        completion(.success(items))
                    case .failure:
                        completion(.failure(.networkError))
                }
            }
        )
    }
}
