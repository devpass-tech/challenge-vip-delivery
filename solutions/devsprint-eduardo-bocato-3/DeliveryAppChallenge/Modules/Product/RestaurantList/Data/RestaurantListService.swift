//
//  RestaurantListRepositoryImpl.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 04/11/22.
//

import Foundation

enum RestaurantListServiceError: Error {
    case serialization(_ error: Error?)
    case invalidData
}

protocol RestaurantListServiceProtocol {
    func getItems(then: @escaping (Result<[Restaurant], RestaurantListServiceError>) -> Void)
}

class RestaurantListService: RestaurantListServiceProtocol {
    func getItems(then: @escaping (Result<[Restaurant], RestaurantListServiceError>) -> Void) {
        guard let jsonData = jsonData else {
            return then(.failure(.invalidData))
        }
        do {
            let value = try JSONDecoder().decode([Restaurant].self, from: jsonData)
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                then(.success(value))
            }
        } catch {
            then(.failure(.serialization(error)))
        }
    }
    
    private let jsonData: Data? = """
    [
        {
            "name": "Benjamin a Padaria",
            "category": "Padaria",
            "delivery_time": {
                "min": 23,
                "max": 33
            }
        },
        {
            "name": "Pecorino a Trattoria",
            "category": "Italiana",
            "delivery_time": {
                "min": 38,
                "max": 48
            }
        },
        {
            "name": "Bar do Alemão",
            "category": "Brasileira",
            "delivery_time": {
                "min": 42,
                "max": 52
            }
        },
        {
            "name": "Benjamin a Padaria",
            "category": "Padaria",
            "delivery_time": {
                "min": 23,
                "max": 33
            }
        },
        {
            "name": "Abbraccio",
            "category": "Italiana",
            "delivery_time": {
                "min": 65,
                "max": 75
            }
        },
        {
            "name": "Poke Garden",
            "category": "Japonesa",
            "delivery_time": {
                "min": 36,
                "max": 46
            }
        },
        {
            "name": "Bar do Juarez",
            "category": "Brasileira",
            "delivery_time": {
                "min": 41,
                "max": 51
            }
        },
        {
            "name": "Tradi Vila Nova",
            "category": "Hambúrguer",
            "delivery_time": {
                "min": 28,
                "max": 38
            }
        },
        {
            "name": "1900 Pizzeria",
            "category": "Pizza",
            "delivery_time": {
                "min": 45,
                "max": 55
            }
        },
        {
            "name": "Estella Burger",
            "category": "Hambúrguer",
            "delivery_time": {
                "min": 17,
                "max": 27
            }
        },
        {
            "name": "Tacomex",
            "category": "Mexicana",
            "delivery_time": {
                "min": 17,
                "max": 27
            }
        }
    ]
    """.data(using: .utf8)
}
