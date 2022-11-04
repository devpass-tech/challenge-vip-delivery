//
//  RestaurantListRepositoryImpl.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 04/11/22.
//

import Foundation

class RestaurantListRepositoryImpl: RestaurantListRepository {
    func getData() -> Data? {
        return jsonData.data(using: .utf8)
    }
    
    private let jsonData: String = """
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
    """
}
