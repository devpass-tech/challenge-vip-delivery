//
//  PTLoginWorker.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 25/07/22.
//

import Foundation
import UIKit

final class PTLoginWorker {
    
    private let service: BadNetworkLayer
    
    init() {
        self.service = BadNetworkLayer.shared
    }
    
    func fetchLogin(vc: UIViewController, parameters: [String : String], completion: @escaping ((Result<Session, Error>) -> Void)) {
        service.login(vc, parameters: parameters) { result in
            DispatchQueue.main.async {
                switch result {
                case .some(let result):
                    completion(.success(result))
                case .none:
                    print("Error to return session")
                }
            }
        }
    }
}
