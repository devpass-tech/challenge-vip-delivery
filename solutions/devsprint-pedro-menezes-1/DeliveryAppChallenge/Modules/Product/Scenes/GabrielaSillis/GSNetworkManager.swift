//
//  GSNetworkManager.swift
//  DeliveryAppChallenge
//
//  Created by Gabriela Sillis on 21/07/22.
//

import Foundation

typealias RequestResult = Result<Session, NetworkRequestErrors>

protocol GSNetworkRequesting {
    func makeAuthenticationRequest(userData: UserEmailAndPasswordData, completion: @escaping (RequestResult) -> Void)
}

final class GSNetworkManager: GSNetworkRequesting {
    func makeAuthenticationRequest(userData: UserEmailAndPasswordData, completion: @escaping (RequestResult) -> Void) {
        let parameters = getParameters(email: userData.email, password: userData.password)
        let endpoint = Endpoints.Auth.login
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    if let result = try self.decodeJsonFrom(data: data) {
                        completion(.success(result))
                    }
                } catch  {
                    completion(.failure(NetworkRequestErrors.errorToDecode))
                }
            case .failure:
                completion(.failure(.badRequest))
            }
        }
    }
}

private extension GSNetworkManager {
    func getParameters(email: String, password: String) -> [String: String] {
        let parameters: [String: String] = ["email": email,
                                            "password": password]
        return parameters
    }
    
    func decodeJsonFrom(data: Data) throws -> Session? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Session.self, from: data)
        } catch {
            return nil
        }
    }
}

