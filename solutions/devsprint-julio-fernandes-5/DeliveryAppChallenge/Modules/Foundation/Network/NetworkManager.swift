//
//  NetworkManager.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 18/04/22.
//

import Foundation

typealias NetworkResult<T: Decodable> = ((Result<T, Error>) -> Void)

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>)
}

final class NetworkManager: NetworkManagerProtocol {
    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func request<T>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>) {
        guard let url = URL(string: request.baseURL + request.pathURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue.uppercased()

        urlSession.loadData(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidStatusCode))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))

            } catch {
                completion(.failure(NetworkError.decodeError))
            }
        }
    }
}

