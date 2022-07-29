//
//  BadNetworkLayer.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Almeida on 27/07/22.
//

import UIKit

class LABadNetworkLayer {
    
    func login(_ targetVc: UIViewController,
               parameters: [String : String],
               completionHandler: @escaping (Session?) -> Void) {
        
        DispatchQueue.main.async {
            targetVc.showLoading()
        }
        
        let endpoint = Endpoints.Auth.login
        
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { result in
            targetVc.stopLoading()
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                if let session = try? decoder.decode(Session.self, from: data) {
                    completionHandler(session)
                } else {
                    completionHandler(nil)
                }
                
            case .failure(let error):
                print("error Login: \(error.localizedDescription)")
                completionHandler(nil)
            }
        }
    }
}
