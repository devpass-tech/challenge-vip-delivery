//
//  FeatureFactory.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 18/04/22.
//

import UIKit

protocol FeatureFactory {
    associatedtype Dependencies
    static func make(with dependencies: Dependencies) -> UIViewController
}
