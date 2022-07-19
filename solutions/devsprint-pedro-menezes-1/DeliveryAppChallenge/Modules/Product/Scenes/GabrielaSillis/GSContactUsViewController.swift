//
//  ContactUsViewController.swift
//  DeliveryAppChallenge
//
//  Created by Pedro Menezes on 17/07/22.
//

import UIKit

class GSContactUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


enum GSContactUsService {
    func pegarDados() {
        let url = Endpoints.contactUs
        AF.request(url, method: .get, parameters: nil, headers: nil) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let session = try? decoder.decode(ContactUsModel.self, from: data) {
                    print("sucesso")
                } else {
                    print("nao conseguiu decodificar")
                }
            case .failure(let error):
                print("error api: \(error.localizedDescription)")
            }
        }
    }

    func enviarMensagem() {
        let parameters: [String: String] = [
            "email": "",
            "mensagem": ""
        ]
        let url = Endpoints.sendMessage
        AF.request(url, method: .post, parameters: parameters, headers: nil) { result in
            switch result {
            case .success:
                print("sucesso")
            case .failure(let error):
                print("error api: \(error.localizedDescription)")
            }
        }
    }
}
