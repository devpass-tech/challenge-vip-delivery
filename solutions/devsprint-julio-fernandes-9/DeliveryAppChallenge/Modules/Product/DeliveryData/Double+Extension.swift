//
//  Double+Extension.swift
//  DeliveryApp
//
//  Created by Alexandre Robaert on 21/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

extension Double {
    public var currency: String {
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        return formater.string(from: NSNumber(value: self))!
    }
}
