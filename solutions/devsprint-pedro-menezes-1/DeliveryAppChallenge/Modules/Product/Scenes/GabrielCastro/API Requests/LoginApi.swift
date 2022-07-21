//
//  LoginApi.swift
//  DeliveryAppChallenge
//
//  Created by Gabriel de Castro Chaves on 21/07/22.
//
protocol LoginApiDelegate: AnyObject {
    func setErrorLogin(_ message: String)
}

import UIKit

struct LoginApi  {
    
    weak var delegate: LoginApiDelegate?
    
    func apiRequest(emailParameter: UITextField, passwordParameter: UITextField) {
        let parameters: [String: String] = ["email": emailParameter.text!,
                                            "password": passwordParameter.text!]
        let endpoint = Endpoints.Auth.login
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { result in
            DispatchQueue.main.async {
                UIViewController().stopLoading()
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    if let session = try? decoder.decode(Session.self, from: data) {
                        Coordinator().showViewController(vc: UINavigationController(rootViewController: HomeViewController()))
                        UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
                    } else {
                        Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: GCLoginViewController())
                    }
                case .failure:
                    self.handleFailure(GCLoginViewController())
                }
            }
        }
    }
    
    
    func handleSuccess(data: Data) {
        
    }
    
    func handleFailure(_ controller: UIViewController) {
        delegate?.setErrorLogin("E-mail ou senha incorretos")
        Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: controller)
    }
}
