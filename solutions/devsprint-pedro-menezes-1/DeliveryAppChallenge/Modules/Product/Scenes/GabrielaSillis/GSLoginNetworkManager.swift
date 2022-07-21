//
//  GSNetworkManager.swift
//  DeliveryAppChallenge
//
//  Created by Gabriela Sillis on 21/07/22.
//

import Foundation

typealias UserSessionResult = Result<Session, GSNetworkRequestErrors>

protocol GSLoginNetworkRequesting {
    func makeLoginAuthenticationRequest(userData: UserEmailAndPasswordData, completion: @escaping (UserSessionResult) -> Void)
}

final class GSLoginNetworkManager: GSLoginNetworkRequesting {
    func makeLoginAuthenticationRequest(userData: UserEmailAndPasswordData, completion: @escaping (UserSessionResult) -> Void) {
        let parameters = getParametersLoginAuthentication(email: userData.email, password: userData.password)
        let endpoint = Endpoints.Auth.login
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let result = try self.returnsJsonDecodedFrom(data: data)
                    completion(.success(result))
                } catch  {
                    completion(.failure(GSNetworkRequestErrors.errorToDecode))
                }
            case .failure:
                completion(.failure(.badRequest))
            }
        }
    }
}

private extension GSLoginNetworkManager {
    func getParametersLoginAuthentication(email: String, password: String) -> [String: String] {
        let parameters: [String: String] = ["email": email,
                                            "password": password]
        return parameters
    }
    
    func returnsJsonDecodedFrom(data: Data) throws -> Session {
        let decoder = JSONDecoder()
        do {
            let session = try decoder.decode(Session.self, from: data)
            return session
        } catch {
            throw GSNetworkRequestErrors.errorToDecode
        }
    }
}

